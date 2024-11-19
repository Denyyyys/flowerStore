Rails.application.routes.draw do
  # root "pages#home"
  root "flowers#index"
  # devise_for :users, :controllers => { :registrations => "users/registrations" }
  # devise_for :users

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


  resources :flowers do
    post 'add_to_cart', on: :member
  end

  get '/profile', to: 'profile#index', as: 'profile_path'
  get 'order_success', to: 'profile#order_success', as: 'order_success_path'
  get '/profile/add_savings', to: 'profile#add_savings'
  patch '/profile/update_savings', to: 'profile#update_savings', as: 'update_savings_profile'
  post '/profile/create_order', to: 'profile#create_order', as: 'create_order_profile'

  patch '/orders/:id/update_status', to: 'orders#update_status', as: 'update_order_status'
  patch '/update_multiple_orders', to: 'orders#update_multiple_statuses', as: 'update_multiple_orders'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
