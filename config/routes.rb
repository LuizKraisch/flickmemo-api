# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :auth, except: %i[index create show update destroy] do
        post 'access', on: :collection
      end
      resources :users, only: %i[show update destroy] do
        get 'recent', on: :member
        get 'watchlist', on: :member
        get 'favorites', on: :member
      end
      resources :movies, only: %i[show] do
        get 'search', on: :collection
        get 'similar', on: :member
        get 'discover', on: :collection
        get 'trending', on: :collection
        get 'add_to_watchlist', on: :collection
        get 'remove_from_watchlist', on: :collection
      end
      resources :reviews, except: :index
    end
  end
end
