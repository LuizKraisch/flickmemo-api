# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
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
        params = '&page=1'

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

      private

      def movie_service
        MovieService.new
      end

      def movie_params
        params.permit(:query)
      end
    end
  end
end
