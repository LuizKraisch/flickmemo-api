# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :set_user, only: %i[show destroy favorite_movies movies watchlist]

      def show
        render json: sanitize_user(@user.as_json), status: :ok
      end

      def destroy
        @user.destroy
      end

      def movies
        # TODO: Implement
      end

      def watchlist
        # TODO: Implement
      end

      def favorites
        movies = Movie.joins(list: :user)
                      .where(users: { id: @user.id })
                      .where(movies: { favorite: true })

        render json: movies, status: :ok
      end

      private

      def tmdb_service
        MovieService.new
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.fetch(:user, {})
      end

      def sanitize_user(data)
        data.except('id', 'api_token_id')
      end
    end
  end
end
