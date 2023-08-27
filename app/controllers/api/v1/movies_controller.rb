require_relative '../../../services/tmdb_service.rb'

class Api::V1::MoviesController < Api::V1::BaseController
  def show
    path = "movie/#{params[:id]}"
    language = 'en-US' # TODO: Use user defined language

    data = TMDBService.access_external_api(path, language)

    render json: data.read_body
  end
end
