Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :gigs, only: [:index, :show] do
    resources :registrations, only: [:new]
  end

  # Defines the root path route ("/")
  # root "posts#index"

  patch "profile" => "users#update"

  get "profile/edit" => "users#edit"

  get "dashboard" => "users#dashboard"

  # ROUTES: WIP
  resource :user, only: [:show, :edit, :update]

  # GIG ROUTES
  resources :gigs

  # MESSAGE ROUTES
  get 'gigs/:gig_id/messages/:id', to: 'messages#show', as: 'gig_message'

end
