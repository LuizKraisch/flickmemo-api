# frozen_string_literal: true

class User < ApplicationRecord
  has_one :api_token
  has_many :lists
  has_many :reviews
  has_many :movies, through: :reviews

  after_create :create_token
  before_destroy :destroy_token

  validates :google_user_uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :preferred_language, presence: true

  delegate :token, to: :api_token

  def recent_movies
    Movie.joins(lists: :user)
         .where(users: { id: })
         .where(lists: { list_type: 'watched' })
  end

  def watchlist_movies
    Movie.joins(lists: :user)
         .where(users: { id: })
         .where(lists: { list_type: 'watchlist' })
  end

  def favorite_movies
    Movie.joins(reviews: :user)
         .where(users: { id: })
         .where(reviews: { favorite: true })
  end

  private

  def create_token
    api_token = ApiToken.create(user_id: id, active: true)
    self.api_token_id = api_token.id
    save
  end

  def destroy_token
    ApiToken.create(user_id: id).delete
  end
end
