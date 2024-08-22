# This initializer configures OmniAuth to use Spotify as an authentication provider.
# It sets up the middleware to handle OAuth authentication with Spotify, using the
# client ID and client secret stored in environment variables. The specified scope
# determines the permissions the application will request from the user, including:
# - user-read-email: Read access to the user's email address.
# - playlist-modify-public: Write access to a user's public playlists.
# - user-library-read: Read access to a user's "Your Music" library.
# - user-library-modify: Write/delete access to a user's "Your Music" library.

require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: "user-read-email user-library-read"
end
