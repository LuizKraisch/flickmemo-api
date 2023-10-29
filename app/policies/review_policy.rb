# frozen_string_literal: true

class ReviewPolicy
  attr_reader :user, :review

  def initialize(user, review)
    @user = user
    @review = review
  end

  class Scope < ReviewPolicy
    def resolve
      Review.where(user_id: @user.id)
    end
  end

  def show?
    @user.present? && (@review.user == @user)
  end

  def create?
    @user.present?
  end

  def update?
    @user.present? && @review.present? && (@review.user == @user)
  end

  def destroy?
    @user.present? && @review.present? && (@review.user == @user)
  end
end
