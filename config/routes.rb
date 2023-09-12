# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :auth, except: %i[index create show update destroy] do
        get 'check_access', on: :collection
      end
      resources :users, only: :show do
        get 'favorite_movies', on: :member
        get 'movies', on: :member
        get 'watchlist', on: :member
      end
      resources :movies, only: %i[create show] do
        get 'similar_movies', on: :member
        get 'reviews', on: :member
        get 'discover', on: :collection
        get 'trending', on: :collection
      end
    end
  end
end
