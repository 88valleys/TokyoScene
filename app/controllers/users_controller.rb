class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :add_genre, :remove_genre]
  def show
    @user = User.find(params[:id])  # Assuming you have a User model and want to show a specific user profile
  end

  # def edit
  #   @current_user = current_user
  # end

  # def update
  #   @current_user = current_user

  #   genres = params["user"]["genres"]
  #   @current_user.genre_list.add(genres)
  #   @current_user.save
  #   # to do: redirect to profile page

  #   redirect_to profile_path(@current_user)
  # end

  def dashboard
    @genres = ActsAsTaggableOn::Tag.all
  end

  # genres
  # events
  # artists
  # recommendations

  def registered_gigs
    @registered_gigs = current_user.registered_gigs
  end

  def remove_genre
    p @user
    @user.genre_list.remove(user_params[:genre])
    @user.save
    redirect_to dashboard_path(@user), notice: 'Genre removed successfully.'
  end

  def add_genre
    @user.genre_list.add(user_params[:genre])
    @user.save
    redirect_to dashboard_path(@user), notice: 'Genre added successfully.'
  end

  def user_params
    params.require(:user).permit(:genre)
  end

  private

  def set_user
    @user = current_user
  end

end

# #genre management
#   def add_genre
#     genre = params[:genre]
#     @current_user.genre_list.add(genre)
#     @current_user.save
#     redirect_to profile_path(@current_user), notice: 'Genre added successfully.'
#   end
