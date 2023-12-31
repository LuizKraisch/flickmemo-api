# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :set_user, only: %i[show update destroy recent watchlist favorites]

      def show
        data = build_user(@user.as_json)

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :unprocessable_entity
        end
      end

      def update
        authorize @user

        if @user.update(user_params)
          render json: { message: 'User updated.', user: @user.to_json }, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @user

        if @user.destroy
          render json: { message: 'User and token deleted.' }, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def recent
        movies = @user.recent_movies

        data = []
        movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil, @user.preferred_language).read_body
          data << movie_service.sanitize_poster(JSON.parse(raw_data))
        end

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def watchlist
        watchlist_movies = @user.watchlist_movies

        data = []
        watchlist_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil, @user.preferred_language).read_body
          data << movie_service.sanitize_poster(JSON.parse(raw_data))
        end

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def favorites
        favorite_movies = @user.favorite_movies

        data = []
        favorite_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil, @user.preferred_language).read_body
          data << movie_service.sanitize_poster(JSON.parse(raw_data))
        end

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      private

      def movie_service
        MovieService.new
      end

      def set_user
        @user = User.find_by!(uuid: params[:id])
      end

      def user_params
        params.require('user').permit(:id, :first_name, :last_name, :email, :preferred_language)
      end

      def build_user(data)
        count =
          {
            internal_id: @user.uuid,
            watched_count: @user.recent_movies.count.to_s,
            favorites_count: @user.favorite_movies.count.to_s,
            watchlist_count: @user.watchlist_movies.count.to_s
          }

        final_data = data.merge(count)
        final_data.except('id', 'uuid', 'api_token_id', 'updated_at', 'google_user_uid', 'email')
      end
    end
  end
end
