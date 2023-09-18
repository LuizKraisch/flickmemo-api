# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < Api::V1::BaseController
      before_action :set_review, only: %i[show update destroy]

      def show
        render json: @review, status: :ok
      end

      def create
        @review = Review.new(review_params)

        if @review.save
          render json: @review, location: @review
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      def update
        if @review.update(review_params)
          render json: @review, status: :ok
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @review.destroy
      end

      private

      def set_review
        @review = Review.find(params[:id])
      end

      def review_params
        params.require('review').permit(:id)
      end
    end
  end
end
