Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:index]
      resources :movies, only: [:create, :show] do
        get 'discover', on: :collection
        get 'similar_movies', on: :member
        get 'trending', on: :collection
      end
    end  
  end
end
