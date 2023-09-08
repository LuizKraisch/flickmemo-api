# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
      def show
        path = "movie/#{params[:id]}"
        data = tmdb_service.access_external_api(path, nil)

        render json: sanitize_movie(data.read_body)
      end

      def discover
        # Check which option is the best.

        path = 'discover/movie'
        params = '&page=1&sort_by=vote_average.desc'

        # movie_id = @current_user.favorite_movies.first
        # path = "movie/#{movie_id}/recommendations"
        # params = "&page=1"

        data = tmdb_service.access_external_api(path, params)

        render json: sanitize_movie(data.read_body)
      end

      def similar_movies
        path = "movie/#{movie_params[:external_id]}/similar"
        params = '&page=1'

        data = tmdb_service.access_external_api(path, params)

        render json: sanitize_movie(data.read_body)
      end

      def trending
        path = 'trending/movie/week'
        params = '&page=1'

        data = tmdb_service.access_external_api(path, params)

        render json: sanitize_movie(data.read_body)
      end

      private

      def tmdb_service
        TMDBService.new
      end

      def movie_params
        params.require('movie').permit(:external_id, :score, :note, :note_has_spoilers, :favorite)
      end

      def sanitize_movie(raw_data)
        raw_data.slice(
          :adult, :belongs_to_collection, :budget,
          :homepage, :original_title, :production_companies,
          :production_countries, :revenue, :video, :vote_count
        )
      end
    end
  end
end
