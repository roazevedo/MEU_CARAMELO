Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
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
