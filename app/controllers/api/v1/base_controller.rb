# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::Base
      include Pundit::Authorization

      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from ActionController::ParameterMissing, with: :handle_bad_authentication
      rescue_from Pundit::NotAuthorizedError, with: :handle_record_not_authorized

      before_action :authenticate

      attr_reader :current_user

      private

      def authenticate
        authenticate_user_with_token || handle_bad_authentication
      end

      def authenticate_user_with_token
        access_token = params.require(:accessToken)
        google_user_id = params.require(:googleUserId)

        return handle_bad_authentication if access_token.nil?

        @api_token = ApiToken.find_by(active: true, token: access_token)

        return handle_bad_authentication if @api_token.nil?

        return handle_user_not_found unless check_user(google_user_id)

        @current_user = @api_token.user
      end

      def handle_bad_authentication
        render json: { message: 'Bad credentials. Please, check your access.' }, status: :unauthorized
      end

      def handle_user_not_found
        render json: { message: 'User not found. Please, check your access.' }, status: :not_found
      end

      def handle_not_found
        render json: { message: 'Record not found.' }, status: :not_found
      end

      def handle_record_not_authorized
        render json: { message: 'Record not authorized. Please, check your access.' }, status: :unauthorized
      end

      def check_user(google_user_uid)
        @api_token.user.present? && @api_token.user.google_user_uid == google_user_uid
      end
    end
  end
end
