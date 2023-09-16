# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::Base
      include Pundit::Authorization

      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

      before_action :authenticate

      attr_reader :current_user

      private

      def authenticate
        authenticate_user_with_token || handle_bad_authentication
      end

      def authenticate_user_with_token
        return handle_bad_authentication if params[:user].nil?

        @api_token = ApiToken.where(active: true, token: user_params[:token])

        return handle_bad_authentication if @api_token.nil

        return handle_user_not_found if check_user(user_params[:email])

        @current_user = @api_token.user
      end

      def handle_bad_authentication
        render json: { message: 'Bad credentials.' }, status: :unauthorized
      end

      def handle_not_found
        render json: { message: 'Record not found.' }, status: :not_found
      end

      def handle_user_not_found
        render json: { message: 'User not found.' }, status: :not_found
      end

      def user_params
        params.require('user').permit(:token, :email)
      end

      def check_user(email)
        !@api_token.user.nil? && @api_token.user.email == email
      end
    end
  end
end
