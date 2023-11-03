Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'user', to: 'users/registrations#new_user'
    post 'user', to: 'users/registrations#create_user'
  end
  
  root to: "home#index"
  resources :families
end
