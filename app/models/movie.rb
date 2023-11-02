# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :reviews

  validates :external_id, presence: true

  def find_similar_movies
    path = "movie/#{external_id}/similar"
    params = '&page=1'

    data = movie_service.access_external_api(path, params)
    movie_service.sanitize_multiple_posters(data)
  end

  def find_tmdb_reviews
    path = "movie/#{external_id}/reviews"
    params = '&page=1'

    data = movie_service.access_external_api(path, params)
    review_service.sanitize_reviews(data)
  end

  private

  def movie_service
    MovieService.new
  end

  def review_service
    ReviewService.new
  end
end
