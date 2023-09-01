class Api::V1::MoviesController < Api::V1::BaseController
  def create
    @movie = Movie.new(movie_params, user: @current_user)

    if @movie.save
      render json: { movie: @movie.to_json, message: "Review added" }, status: :ok
    else
      render json: { message: "Sorry, we couldn't add your review. Please try again" }, status: :internal_server_error
    end
  end

  def show
    path = "movie/#{params[:id]}"
    data = tmdb_service.access_external_api(path, nil)

    render json: data.read_body
  end

  def discover
    # Check which option is the best.

    path = "discover/movie"
    params = "&page=1&sort_by=vote_average.desc"

    movie_id = @current_user.favorite_movies.first
    path = "movie/#{movie_id}/recommendations"
    params = "&page=1"

    data = tmdb_service.access_external_api(path, params)

    render json: data.read_body
  end

  def similar_movies
    path = "movie/#{params[:id]}/similar"
    params = "&page=1"

    data = tmdb_service.access_external_api(path, params)

    render json: data.read_body
  end

  def trending
    path = "trending/movie/week"
    params = "&page=1"

    data = tmdb_service.access_external_api(path, params)

    render json: data.read_body
  end

  private

  def tmdb_service
    TMDBService.new
  end

  def movie_params
    params.require(:movie).permit(:external_id, :score, :note, :note_has_spoilers, :favorite)
  end
end
