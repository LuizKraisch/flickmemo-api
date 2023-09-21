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

  def sanitize_multiple_movies(data)
    return if data.read_body.empty?

    movies = []
    JSON.parse(data.read_body)['results'].each do |movie|
      movies << sanitize_movie(movie)
    end
    movies
  end

  def sanitize_movie(data)
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
      'status', 'tagline', 'title', 'vote_average'
    )
  end

  private

  def build_tmdb_api_url(path, params)
    "#{base_url}#{path}?language=en-US&#{params}" # TODO: Use user defined language
  end

  def base_url
    'https://api.themoviedb.org/3/'
  end

  def token
    ENV.fetch('TMDB_API_TOKEN', nil)
  end
end
