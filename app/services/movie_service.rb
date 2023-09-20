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
    return if data.empty?

    movies = []
    JSON.parse(data.read_body)['results'].each do |movie|
      movies << sanitize_movie(movie)
    end
    movies
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
