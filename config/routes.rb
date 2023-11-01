Rails.application.routes.draw do
  get 'families/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'home/index'
  root to: "home#index"
  resources :families
end