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
    watched_list = lists.find_by(list_type: 'watched')

    return [] if watched_list.nil?

    watched_list.movies.order(created_at: :desc)
  end

  def watchlist_movies
    watchlist = lists.find_by(list_type: 'watchlist')

    return [] if watchlist.nil?

    watchlist.movies.order(created_at: :desc)
  end

  def favorite_movies
    favorite_reviews = reviews.where(favorite: true)

    return [] if favorite_reviews.nil?

    favorite_reviews.map(&:movie)
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
