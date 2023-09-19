# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :auth, except: %i[index create show update destroy] do
        get 'access', on: :collection
      end
      resources :users, only: %i[show destroy] do
        get 'favorites', on: :member
        get 'movies', on: :member
        get 'watchlist', on: :member
      end
      resources :movies, only: %i[show] do
        get 'discover', on: :collection
        get 'trending', on: :collection
        get 'similar', on: :member
      end
      resources :reviews, except: :index
    end
  end
end
