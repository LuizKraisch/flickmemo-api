# frozen_string_literal: true

# spec/services/review_service_spec.rb

require 'rails_helper'

RSpec.describe ReviewService, type: :service do
  describe '#sanitize_reviews' do
    context 'when data is empty' do
      it 'returns null' do
        review_service = ReviewService.new
        expect(review_service.sanitize_reviews(double('data', read_body: ''))).to eq(nil)
      end
    end

    context 'when data is not empty' do
      let(:data) do
        {
          'results' => [
            { 'id' => 1, 'author' => 'Mary Jane',
              'author_details' => 'la la la 1', 'content' => 'haha 1',
              'created_at' => '2022-01-01', 'updated_at' => '2022-01-02' },
            { 'id' => 1, 'author' => 'Florence Jane',
              'author_details' => 'la la la 2', 'content' => 'haha 2',
              'created_at' => '2022-01-02', 'updated_at' => '2022-01-03' },
            { 'id' => 1, 'author' => 'Lila Jane',
              'author_details' => 'la la la 3', 'content' => 'haha 3',
              'created_at' => '2022-01-03', 'updated_at' => '2022-01-04' }
          ]
        }
      end

      it 'returns an array of sanitized reviews' do
        review_service = ReviewService.new
        sanitized_reviews = review_service.sanitize_reviews(double('data', read_body: data.to_json))

        expect(sanitized_reviews).to be_an(Array)
        expect(sanitized_reviews.size).to eq(3)

        sanitized_reviews.each_with_index do |review, index|
          expect(review).to eq(
            'content' => "haha #{index + 1}",
            'created_at' => "2022-01-0#{index + 1}",
            'author_details' => "la la la #{index + 1}"
          )
        end
      end
    end
  end

  describe '#sanitize_review' do
    let(:data) do
      { 'id' => 1, 'author' => 'Mary Jane',
        'author_details' => 'la la la', 'content' => 'haha',
        'created_at' => '2022-01-01', 'updated_at' => '2022-01-02' }
    end

    it 'returns a sanitized review' do
      review_service = ReviewService.new
      sanitized_review = review_service.sanitize_review(data)

      expect(sanitized_review).to eq(
        'content' => 'haha',
        'author_details' => 'la la la',
        'created_at' => '2022-01-01'
      )
    end
  end
end
