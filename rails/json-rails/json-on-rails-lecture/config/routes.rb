Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do
      resources :categories, only: [:index, :show]
      resources :items, only: [:index, :show] do
        resources :reviews, only: :create
      end
    end
  end

end