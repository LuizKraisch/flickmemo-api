# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :set_user, only: %i[show destroy recent watchlist favorites]

      def show
        render json: sanitize_user(@user.as_json), status: :ok
      end

      def destroy
        @user.destroy
      end

      def recent
        recent_movies = Movie.joins(lists: :user)
                             .where(users: { id: @user.id })
                             .where(lists: { list_type: 'watched' })

        data = []
        recent_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          data << movie_service.access_external_api(path, nil)
        end

        render json: movie_service.sanitize_multiple_movies(data), status: :ok
      end

      def watchlist
        watchlist_movies = Movie.joins(lists: :user)
                                .where(users: { id: @user.id })
                                .where(lists: { list_type: 'watchlist' })

        data = []
        watchlist_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          data << movie_service.access_external_api(path, nil)
        end

        render json: movie_service.sanitize_multiple_movies(data), status: :ok
      end

      def favorites
        favorite_movies = Movie.joins(reviews: :user)
                               .where(users: { id: @user.id })
                               .where(reviews: { favorite: true })

        data = []
        favorite_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          data << movie_service.access_external_api(path, nil)
        end

        render json: movie_service.sanitize_multiple_movies(data), status: :ok
      end

      private

      def movie_service
        MovieService.new
      end

      def set_user
        @user = User.find_by!(uuid: params[:id])
      end

      def user_params
        params.fetch(:user, {})
      end

      def sanitize_user(data)
        data.except('id', 'api_token_id', 'updated_at', 'google_user_uid', 'email')
      end
    end
  end
end
