# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
      before_action :set_movie, only: %i[add_to_watchlist remove_from_watchlist]

      def show
        path = "movie/#{params[:id]}"
        data = movie_service.access_external_api(path, nil, @current_user.preferred_language)

        if data
          render json: movie_service.build_movie_info(JSON.parse(data.read_body), @current_user), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :unprocessable_entity
        end
      end

      def search
        path = 'search/movie'
        params = "&query=#{movie_params[:query]}"
        data = movie_service.access_external_api(path, params, @current_user.preferred_language)

        if data
          render json: movie_service.sanitize_movie(JSON.parse(data.read_body)), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def similar
        path = "movie/#{params[:id]}/similar"
        params = '&page=1'

        data = movie_service.access_external_api(path, params, @current_user.preferred_language)

        if data
          render json: movie_service.sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def discover
        path = 'discover/movie'
        params = "&page=#{random_page}&release_date.gte=2009-01-01&release_date.lte=2024-01-01&sort_by=#{random_sort}"

        data = movie_service.access_external_api(path, params, @current_user.preferred_language)

        if data
          render json: movie_service.sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def trending
        path = 'trending/movie/week'
        params = '&page=1'

        data = movie_service.access_external_api(path, params, @current_user.preferred_language)

        if data
          render json: movie_service.sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def add_to_watchlist
        watchlist = @current_user.lists.find_by(list_type: 'watchlist')

        if watchlist.movies.include?(@movie)
          render json: { message: 'Movie is already on the watchlist.' }, status: :conflict
        elsif watchlist.movies << @movie
          render json: { message: 'Movie added to watchlist.' }, status: :ok
        else
          render json: { message: 'Movie or watchlist not found.' }, status: :not_found
        end
      end

      def remove_from_watchlist
        watched_list = @current_user.lists.find_by(list_type: 'watchlist')

        if @movie && watched_list
          if watched_list.movies.destroy(@movie)
            render json: { message: 'Movie removed from watchlist.' }, status: :ok
          else
            render json: { message: 'An error occurred while removing the movie.' }, status: :unprocessable_entity
          end
        else
          render json: { message: 'Movie or watchlist not found.' }, status: :not_found
        end
      end

      private

      def set_movie
        @movie = Movie.find_by!(external_id: movie_params[:movieId])
      end

      def movie_service
        MovieService.new
      end

      def movie_params
        params.permit(:query, :movieId)
      end

      def random_page = rand(1..30)

      def random_sort
        # TODO: See more sort options from TMDB
        %w[vote_count.desc].sample
      end
    end
  end
end
