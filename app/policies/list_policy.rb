# frozen_string_literal: true

class ListPolicy
  attr_reader :user, :movie

  def initialize(user, list)
    @user = user
    @list = list
  end

  class Scope < Scope
    def resolve
      scope.where(user:)
    end
  end

  def show?
    user.present?
  end
end
