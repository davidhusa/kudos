Rails.application.routes.draw do
  devise_for :users
  resources :teams do
    get 'join', on: :member
    get 'quit', on: :member
    resources :kudos
  end
  resources :accounts

  root "teams#index"
end
