class UsersController < ApplicationController
  def edit
    @current_user = current_user
  end

  def update
    @current_user = current_user

    genres = params['user']['genres']
    @current_user.genre_list.add(genres)
    @current_user.save
    # to do: redirect to profile page
  end
end
