# frozen_string_literal: true

class ReviewService
  def sanitize_reviews(data)
    return if data.read_body.empty?

    reviews = []
    JSON.parse(data.read_body)['results'].each do |movie|
      reviews << sanitize_review(movie)
    end
    reviews
  end

  def sanitize_review(data)
    data.except('id', 'author', 'updated_at', 'url')
  end
end
