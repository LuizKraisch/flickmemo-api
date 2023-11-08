# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :set_user, only: %i[show destroy recent watchlist favorites add_to_watchlist remove_from_watchlist]

      def show
        # authorize @user

        data = build_user(@user.as_json)

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
        recent_movies = @user.recent_movies

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
        watchlist_movies = @user.watchlist_movies

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
        favorite_movies = @user.favorite_movies

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

      def add_to_watchlist
        movie = Movie.find_by!(uuid: user_params[:movieId])

        if @user.lists.find_by(list_type: 'watched').movies << movie
          render json: { message: 'Movie added to watchlist.' }, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :ok
        end
      end

      def remove_from_watchlist
        movie = Movie.find_by!(uuid: user_params[:movieId])
        watched_list = @user.lists.find_by(list_type: 'watched')

        if movie && watched_list
          if watched_list.movies.destroy(movie)
            render json: { message: 'Movie removed from watchlist.' }, status: :ok
          else
            render json: { message: 'An error occurred while removing the movie.' }, status: :unprocessable_entity
          end
        else
          render json: { message: 'Movie or watched list not found.' }, status: :not_found
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
        params.permit(:id, :movieId)
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
