Rails.application.routes.draw do
  devise_for :users
  post "users", to: "users#create"
  get "users/:id", to: "users#show", as: :user
  get "users/:id/edit", to: "users#edit", as: :edit_user
  patch "users/:id", to: "users#update"

  root to: "pages#home"
  get "users/:id/dashboard", to: "pages#dashboard", as: :dashboard

 resources :adoption_forms, only: [:index, :show, :new, :create, :edit, :update]

  # get "adoptionforms/:id", to: "adoptionforms#show", as: :adoptionform
  # get "adoptionforms/new", to: "adoptionforms#new", as: :new_adoptionform
  # post "adoptionforms", to: "adoptionforms#create"
  # get "adoptionforms/:id/edit", to: "adoptionforms#edit"
  # patch "adoptionforms/:id", to: "adoptionforms#update"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  patch "adoptions/:id/update_status", to: "adoptions#update_status", as: :update_status
  patch "adoptions/:id/update_done", to: "adoptions#done", as: :done

  resources :animals
  resources :users do
    resources :animals do
      resources :adoptions, only: [:index, :show, :new, :create, :edit, :update] do
        resources :testimonies, only: [:index, :new, :create, :show, :edit, :update]
      end
    end
  end
end
