# frozen_string_literal: true

require 'uri'
require 'net/http'

class MovieService
  def access_external_api(path, params)
    url = URI(build_tmdb_api_url(path, params))

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request['accept'] = 'application/json'
    request['Authorization'] = "Bearer #{token}"

    http.request(request)
  end

  def build_movie_info(movie, user)
    {
      data: sanitize_movie(movie),
      user_review: find_user_review(movie['id'], user.id),
      tmdb_reviews: find_tmdb_reviews(movie['id']),
      similar: find_similar_movies(movie['id'])
    }
  end

  def create_or_find(movie_id)
    movie = Movie.find_by(external_id: movie_id) \

    return movie unless movie.nil?

    Movie.create(external_id: movie_id)
  end

  def find_user_review(movie_id, user_id)
    movie = create_or_find(movie_id)
    review = movie.reviews.where(user_id:).first

    review&.to_hash
  end

  def find_tmdb_reviews(movie_id)
    movie = create_or_find(movie_id)
    movie.find_tmdb_reviews
  end

  def find_similar_movies(movie_id)
    movie = create_or_find(movie_id)
    movie.find_similar_movies
  end

  def sanitize_multiple_movies(data)
    return if data.read_body.empty?

    movies = []
    JSON.parse(data.read_body)['results'].each do |movie|
      movies << sanitize_movie(movie)
    end
    movies
  end

  def sanitize_multiple_posters(data)
    return if data.read_body.empty?

    movies = []
    JSON.parse(data.read_body)['results'].each do |movie|
      movies << sanitize_poster(movie)
    end
    movies
  end

  def sanitize_movie(data)
    movie = create_or_find(data['id'])

    data['uuid'] = movie.uuid
    data['genres'] = data['genres'].map { |genre| genre['name'] } unless data['genres'].nil?
    unless data['spoken_languages'].nil?
      data['spoken_languages'] = data['spoken_languages'].map do |genre|
        genre['name']
      end
    end

    data.except(
      'adult', 'belongs_to_collection', 'budget',
      'homepage', 'original_title', 'production_companies',
      'production_countries', 'revenue', 'video', 'vote_count'
    )
  end

  def sanitize_poster(data)
    data.except(
      'adult', 'belongs_to_collection', 'budget',
      'homepage', 'original_title', 'production_companies',
      'production_countries', 'revenue', 'video', 'vote_count',
      'backdrop_path', 'genres', 'imdb_id', 'original_language',
      'overview', 'popularity', 'release_date', 'runtime', 'spoken_languages',
      'status', 'tagline', 'title', 'vote_average', 'genre_ids'
    )
  end

  private

  def build_tmdb_api_url(path, params)
    "#{base_url}#{path}?language=en-US&#{params}" # TODO: Use user defined language
  end

  def base_url
    ENV.fetch('TMDB_API_BASE_URL', nil)
  end

  def token
    ENV.fetch('TMDB_API_TOKEN', nil)
  end
end
