# frozen_string_literal: true

class UserPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  class Scope < UserPolicy
    def resolve
      User.all
    end
  end

  def show?
    @user.present?
  end

  def destroy
    @user.present?
  end
end
