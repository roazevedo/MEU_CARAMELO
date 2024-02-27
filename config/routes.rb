Rails.application.routes.draw do
  devise_for :users
  post "users", to: "users#create"
  get "users/:id", to: "users#show", as: :user
  get "users/:id/edit", to: "users#edit", as: :edit_user
  patch "users/:id", to: "users#update"
  root to: "pages#home"

  post "adoptionforms", to: "adoptionforms#create"
  get "adoptionforms/new", to: "adoptionforms#new", as: :new_adoptionform
  get "adoptionforms/:id", to: "adoptionforms#show", as: :adoptionform
  get "adoptionforms/:id/edit", to: "adoptionforms#edit", as: :edit_adoptionform
  patch "adoptionforms/:id", to: "adoptionforms#update"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :animals
end
