# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:api_token) }
    it { is_expected.to have_many(:lists) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:movies).through(:reviews) }
  end

  context 'preferred language enum' do
    it 'defines the preferred_language enum with the expected values' do
      expect(User.preferred_languages).to eq({ 'en-US' => 'en-US', 'pt-BR' => 'pt-BR' })
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:google_user_uid) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:preferred_language) }
  end

  describe 'delegations' do
    it { should delegate_method(:token).to(:api_token) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      it 'creates a token and lists after user creation' do
        user = create(:user)
        expect(user.api_token).to be_present
        expect(user.lists.count).to eq(2)
      end
    end
  end

  describe 'movies' do
    describe '#recent_movies' do
      it 'returns recent movies from the watched list' do
        user = create(:user)
        watched_list = user.lists.find_by(list_type: 'watched')
        movie1 = create(:movie)
        movie2 = create(:movie)
        watched_list.movies << [movie1, movie2]

        expect(user.recent_movies).to eq([movie2, movie1])
      end

      it 'returns an empty array if the watched list is nil' do
        user = create(:user)
        expect(user.recent_movies).to eq([])
      end
    end

    describe '#watchlist_movies' do
      it 'returns movies from the watchlist' do
        user = create(:user)
        watchlist = user.lists.find_by(list_type: 'watchlist')
        movie1 = create(:movie)
        movie2 = create(:movie)
        watchlist.movies << [movie1, movie2]

        expect(user.watchlist_movies).to eq([movie2, movie1])
      end

      it 'returns an empty array if the watchlist is nil' do
        user = create(:user)
        expect(user.watchlist_movies).to eq([])
      end
    end

    describe '#favorite_movies' do
      it 'returns favorite movies' do
        user = create(:user)
        movie1 = create(:movie)
        movie2 = create(:movie)
        create(:review, user:, movie: movie1, favorite: true)
        create(:review, user:, movie: movie2, favorite: true)

        expect(user.favorite_movies).to eq([movie1, movie2])
      end

      it 'returns an empty array if there are no favorite movies' do
        user = create(:user)
        expect(user.favorite_movies).to eq([])
      end
    end
  end
end
