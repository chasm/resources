Rails.application.routes.draw do
  resources :cats, except: :destroy
  root to: 'cats#index'
end
