Rails.application.routes.draw do

  # Added this route to allow users to sign in with Spotify
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/gigs", to: "gigs#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :gigs, only: [:index, :show] do
    resources :registrations, only: [:new, :create, :destroy] do
      get "confirm", on: :collection
    end
  end

  patch "profile" => "users#update"
  get "profile/edit" => "users#edit"
  get "dashboard" => "users#dashboard"

  resource :user, only: [:show, :edit, :update] do
    # Route for chatrooms that a user is registered to
    resources :chatrooms, only: [:index]
  end

  # GIG ROUTES
  resources :gigs do
    resource :chatroom, only: [:create, :show, :new]
  end

  # MESSAGE ROUTES
  get "gigs/:gig_id/messages/:id", to: "messages#show", as: "gig_message"

  # CHATROOM ROUTES
  resources :chatrooms, only: :show do
    resources :messages, only: [:create]
  end

  # SPOTIFY: Route to handle the callback from Spotify
  get "/auth/spotify/callback", to: "users#spotify"

  resources :users, only: [:show, :edit, :update] do
    member do
      get "registered_gigs"
      patch "add_genre"
      patch "remove_genre"
      patch "add_artist"
      patch "remove_artist"
    end
  end
end
