Rails.application.routes.draw do
  get 'families/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'user', to: 'families#new_user'
    post 'user', to: 'families#create_user'
  end
  get 'home/index'
  root to: "home#index"
  resources :families
  resources :users
end
