# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < Api::V1::BaseController
      before_action :set_review, only: %i[show update destroy]

      def show
        authorize @review

        if @review
          render json: sanitize_review(@review), status: :ok
        else
          render json: { message: 'Data not available.' }, status: :unprocessable_entity
        end
      end

      def create
        movie = Movie.find_by(external_id: review_params[:movie_id])

        @review = Review.new(review_params)
        @review.user_id = @current_user.id
        @review.movie_id = movie.id

        @current_user.lists.find_by(list_type: 'watched').movies << movie

        authorize @review

        if @review.save
          render json: sanitize_review(@review), status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def update
        authorize @review

        if @review.update(review_params)
          render json: sanitize_review(@review), status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @review

        if @review.destroy
          render json: { message: 'Review deleted.' }, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      private

      def set_review
        @review = policy_scope(Review).find_by!(uuid: params[:id])
      end

      def sanitize_review(data)
        data.to_json(only: %i[uuid score note note_has_spoilers favorite created_at])
      end

      def review_params
        params.require(:review).permit(:score, :note, :note_has_spoilers, :favorite, :movie_id, :uuid)
      end
    end
  end
end
