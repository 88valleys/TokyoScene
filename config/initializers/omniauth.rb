require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :spotify, 
    ENV["SPOTIFY_CLIENT_ID"],
    ENV["SPOTIFY_CLIENT_SECRET"],
    scope: "user-follow-read user-read-email user-top-read user-read-private playlist-modify-public user-library-read user-library-modify"
  )
end

OmniAuth.config.allowed_request_methods = [ :post, :get ]
