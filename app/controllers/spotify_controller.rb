class SpotifyController < ApplicationController
  # this is the callback for the Spotify API it exists to capture the user's credentials and then store them on the user
  def authenticate
    @spotify_user = RSpotify::User.new(request.env["omniauth.auth"])
    current_user.update(
      spotify_access_token: @spotify_user.credentials.token, # necessary
      spotify_refresh_token: @spotify_user.credentials.refresh_token, # necessary
      spotify_id: @spotify_user.id, # not necessary
      spotify_name: @spotify_user.display_name # not necessary
    )

    # redirect to whatever is the most appropriate path for your application
    redirect_to root_path
  end
end
