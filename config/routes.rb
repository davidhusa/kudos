Rails.application.routes.draw do
  devise_for :users
  resources :settings
  resources :kudos
  resources :teams do
    get 'join', on: :member
    get 'quit', on: :member
  end
  resources :accounts

  root "teams#index"
end
