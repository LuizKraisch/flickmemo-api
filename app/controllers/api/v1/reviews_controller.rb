# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < Api::V1::BaseController
      before_action :set_review, only: %i[show update destroy]

      def show
        if @review
          render json: @review, status: :ok
        else
          render json: { message: 'Data not available.' }, status: :unprocessable_entity
        end
      end

      def create
        @review = Review.new(review_params)

        if @review.save
          render json: @review, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def update
        if @review.update(review_params)
          render json: @review, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      def destroy
        if @review.destroy
          render json: { message: 'Review deleted.' }, status: :ok
        else
          render json: { message: 'An error occurred.' }, status: :unprocessable_entity
        end
      end

      private

      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.require('review').permit(:id, :uuid, :score, :note, :note_has_spoilers, :favorite, :user_id, :movie_id)
      end
    end
  end
end
