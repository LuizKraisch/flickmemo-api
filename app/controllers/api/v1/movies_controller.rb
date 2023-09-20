# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
      def show
        path = "movie/#{params[:id]}"
        data = movie_service.access_external_api(path, nil)

        if data
          render json: sanitize_movie(JSON.parse(data.read_body)), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def search
        path = 'search/movie'
        params = "&query=#{movie_params[:query]}"
        data = movie_service.access_external_api(path, params)

        if data
          render json: sanitize_movie(JSON.parse(data.read_body)), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def similar
        path = "movie/#{params[:id]}/similar"
        params = '&page=1'

        data = movie_service.access_external_api(path, params)

        if data
          render json: sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def discover
        path = 'discover/movie'
        params = '&page=1&sort_by=vote_average.desc'

        data = movie_service.access_external_api(path, params)

        if data
          render json: sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      def trending
        path = 'trending/movie/week'
        params = '&page=1'

        data = movie_service.access_external_api(path, params)

        if data
          render json: sanitize_multiple_movies(data), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :internal_server_error
        end
      end

      private

      def movie_service
        MovieService.new
      end

      def sanitize_multiple_movies(raw_data)
        movies = []
        JSON.parse(raw_data.read_body)['results'].each do |movie|
          movies << sanitize_movie(movie)
        end
        movies
      end

      def movie_params
        params.require('movie').permit(:query)
      end

      def sanitize_movie(data)
        data.except(
          'adult', 'belongs_to_collection', 'budget',
          'homepage', 'original_title', 'production_companies',
          'production_countries', 'revenue', 'video', 'vote_count'
        )
      end
    end
  end
end
