# This controller handles the callbacks from OmniAuth providers.
# It is responsible for processing the authentication data returned by the provider,
# finding or creating the user in the database, and signing the user in.
# Specifically, it includes actions for handling the Spotify authentication callback.
# The controller inherits from Devise::OmniauthCallbacksController to leverage Devise's
# built-in OmniAuth support.

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Spotify") if is_navigational_format?
    else
      session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  # You should also handle failure scenarios
  def failure
    redirect_to root_path
  end
end
