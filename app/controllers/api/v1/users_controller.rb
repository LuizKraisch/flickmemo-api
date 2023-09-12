# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      def favorite_movies
        movies = Movie.joins(list: :user)
                      .where(users: { id: @current_user.id })
                      .where(movies: { favorite: true })

        render json: movies, status: :ok
      end

      def movies
        # TODO: Implement
      end

      def watchlist
        # TODO: Implement
      end
    end
  end
end
