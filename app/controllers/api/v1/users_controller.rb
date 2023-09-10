# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      def add_review
        @movie = Movie.new(movie_params, user: @current_user)

        if @movie.save
          render json: { movie: @movie.to_json, message: 'Review added' }, status: :ok
        else
          render json: { message: "Sorry, we couldn't add your review. Please try again" },
                 status: :internal_server_error
        end
      end

      def favorite_movies
        movies = Movie.joins(list: :user)
                      .where(users: { id: @current_user.id })
                      .where(movies: { favorite: true })

        render json: movies, status: :ok
      end
    end
  end
end
