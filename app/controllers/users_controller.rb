class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])  # Assuming you have a User model and want to show a specific user profile
  end

  def edit
    @current_user = current_user
  end

  def update
    @current_user = current_user

    genres = params["user"]["genres"]
    @current_user.genre_list.add(genres)
    @current_user.save
    # to do: redirect to profile page

    redirect_to profile_path(@current_user)
  end

  def dashboard
    @current_user = current_user
  end

  # genres
  # events
  # artists
  # recommendations

  def registered_gigs
    @registered_gigs = current_user.registered_gigs
  end
end
