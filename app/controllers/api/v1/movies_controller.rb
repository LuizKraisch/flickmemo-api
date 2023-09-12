# frozen_string_literal: true

module Api
  module V1
    class MoviesController < Api::V1::BaseController
      def create
        @movie = Movie.new(
          user: @current_user.id,
          external_id: movie_params.external_id,
          score: movie_params.score,
          note: movie_params.score,
          note_has_spoilers: movie_params.note_has_spoilers,
          favorite: movie_params.favorite
        )

        authorize @movie, :create?

        if @movie.save
          render json: { movie: @movie.to_json, message: 'Review added' }, status: :ok
        else
          render json: { message: "Sorry, we couldn't add your review. Please try again" },
                 status: :internal_server_error
        end
      end

      def show
        path = "movie/#{params[:id]}"
        data = tmdb_service.access_external_api(path, nil)

        render json: sanitize_movie(data.read_body)
      end

      def similar_movies
        path = "movie/#{movie_params[:external_id]}/similar"
        params = '&page=1'

        data = tmdb_service.access_external_api(path, params)

        render json: sanitize_movie(data.read_body)
      end

      def review
        # TODO: Implement
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
