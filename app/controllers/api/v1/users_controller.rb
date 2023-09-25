# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :set_user, only: %i[show destroy recent watchlist favorites]

      def show
        # authorize @user

        data = sanitize_user(@user.as_json)

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :unprocessable_entity
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
        recent_movies = Movie.joins(lists: :user)
                             .where(users: { id: @user.id })
                             .where(lists: { list_type: 'watched' })

        data = []
        recent_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil).read_body
          data << movie_service.sanitize_poster(JSON.parse(raw_data))
        end

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def watchlist
        watchlist_movies = Movie.joins(lists: :user)
                                .where(users: { id: @user.id })
                                .where(lists: { list_type: 'watchlist' })

        data = []
        watchlist_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil).read_body
          data << movie_service.sanitize_poster(JSON.parse(raw_data))
        end

        if data
          render json: data, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def favorites
        favorite_movies = Movie.joins(reviews: :user)
                               .where(users: { id: @user.id })
                               .where(reviews: { favorite: true })

        data = []
        favorite_movies.each do |movie|
          path = "movie/#{movie.external_id}"
          raw_data = movie_service.access_external_api(path, nil).read_body
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
        @user = policy_scope(User)
      end

      def user_params
        params.require('user').permit(:id)
      end

      def sanitize_user(data)
        data.except('id', 'api_token_id', 'updated_at', 'google_user_uid', 'email')
      end
    end
  end
end
