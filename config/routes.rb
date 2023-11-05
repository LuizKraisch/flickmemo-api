# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :auth, except: %i[index create show update destroy] do
        post 'access', on: :collection
      end
      resources :users, only: %i[show destroy] do
        get 'recent', on: :member
        get 'watchlist', on: :member
        get 'favorites', on: :member
        get 'add_to_watchlist', on: :member
      end
      resources :movies, only: %i[show] do
        get 'search', on: :collection
        get 'similar', on: :member
        get 'discover', on: :collection
        get 'trending', on: :collection
      end
      resources :reviews, except: :index
    end
  end
end
