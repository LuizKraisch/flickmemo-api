# frozen_string_literal: true

class MoviePolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  class Scope < MoviePolicy
    def resolve
      scope.where(list: { user: })
    end
  end

  def create?
    user.present?
  end

  def show?
    user.present? && user.movies.pluck(:id).include?(movie.id)
  end

  def update?
    user.present? && movie.present? && user.movies.pluck(:id).include?(movie.id)
  end
end
