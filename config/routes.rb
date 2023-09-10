# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users do
        get 'favorite_movies', on: :collection
      end
      resources :movies, only: %i[create show] do
        get 'discover', on: :collection
        get 'similar_movies', on: :member
        get 'trending', on: :collection
      end
    end
  end
end
