# frozen_string_literal: true

module Api
  module V1
    class AuthController < ActionController::Base
      def check_access
        @current_user = UserService.find_or_create_by_google(auth_params)

        return handle_user_not_found if @current_user.nil?

        @api_token = @current_user.api_token

        return handle_token_not_found if api_token.nil?

        render json: { user: build_user_info }, status: :ok
      end

      private

      def handle_user_not_found
        render json: { message: 'User not found. Please, check your access.' }, status: :unauthorized
      end

      def handle_token_not_found
        render json: { message: 'Token not found. Please, check your access.' }, status: :unauthorized
      end

      def auth_params
        params.require('user').permit(:google_user_uid, :email, :first_name, :last_name, :photo_url)
      end

      def build_user_info
        {
          internal_id: @current_user.id,
          token: @api_token,
          first_name: @current_user.first_name,
          last_name: @current_user.last_name,
          email: @current_user.email,
          photo_url: @current_user.photo_url
        }
      end
    end
  end
end
