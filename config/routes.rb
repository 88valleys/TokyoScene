Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/gigs", to: "gigs#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :gigs, only: [:index, :show] do
    resources :registrations, only: [:new, :create] do
      get "confirm", on: :collection
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"

  patch "profile" => "users#update"

  get "profile/edit" => "users#edit"

  get "dashboard" => "users#dashboard"

  # ROUTES: WIP
  resource :user, only: [:show, :edit, :update] do
  # Route for chatrooms that a user is registered to
    resources :chatrooms, only: [:index]
  end

  # GIG ROUTES
  # http://127.0.0.1:3000/gigs/276/chatroom
  resources :gigs do
    resource :chatroom, only: [:create, :show, :new]
  end

  # MESSAGE ROUTES
  get "gigs/:gig_id/messages/:id", to: "messages#show", as: "gig_message"

  # CHATROOM ROUTES
  resources :chatrooms, only: :show do
    resources :messages, only: [:create]
  end

  resources :users do
    get "registered_gigs", on: :member
    patch 'add_genre', on: :member
    patch 'remove_genre', on: :member
  end
end
