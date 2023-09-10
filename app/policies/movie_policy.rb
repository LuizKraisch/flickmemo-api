# frozen_string_literal: true

class MoviePolicy
  attr_reader :user, :movie

  def initialize(user, movie)
    @user = user
    @movie = movie
  end

  class Scope < Scope
    def resolve
      scope.where(list: { user: user.id })
    end
  end

  def create?
    user.present?
  end
end
