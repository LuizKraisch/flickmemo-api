require 'uri'
require 'net/http'

class TMDBService
  def access_external_api(path, language)
    binding.pry
    url = URI(build_tmdb_api_url(path, language))

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{token}"

    http.request(request)
  end

  private

  def build_tmdb_api_url(path, language)
    "#{base_url}#{path}?language=#{language}"
  end

  def base_url
    'https://api.themoviedb.org/3/'
  end

  def token = ENV['TMDB_API_TOKEN']
end
