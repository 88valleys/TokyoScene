class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :add_genre, :remove_genre, :add_artist, :remove_artist, :show]
  before_action :set_devise_mapping, only: [:dashboard]
  before_action :set_resource_class_and_name, only: [:dashboard]

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = current_user
    @genres = ActsAsTaggableOn::Tag.for_context("genre")
    # @genres = ActsAsTaggableOn::Tag.all

    # Convert user's genre list to lowercase
    user_genres = @user.genre_list.map(&:downcase)

    # Fetch recommended gigs based on user's genre list
    if user_genres.present?
      @recommended_gigs = Gig.tagged_with(@user.genre_list, any: true, wild: true)
    else
      @recommended_gigs = []
    end

    # Set a message if there are no recommended gigs
    @recommended_gigs_message = "Sorry, no recommended gigs yet." if @recommended_gigs.empty?

    # Fetching all genres and artists for use in the dashboard
    registered_gigs
  end

  def registered_gigs
    @registered_gigs = current_user.registrations
    @registered_gigs = Registration.joins(:gig, :user).where(user: current_user).order("gigs.time ASC") if params[:sort] == "asc"

    # filter by date
    # @registered_gigs = filter_by_date(@registered_gigs, params[:date_range]) if params[:date_range].present?
  end

  def add_genre
    genre = params[:user][:genre].strip
    if genre.present?
      @user.genre_list.add(genre)
      @user.save
      redirect_to dashboard_path, notice: "Genre added successfully."
    else
      redirect_to dashboard_path, alert: "Genre cannot be empty."
    end
  end

  def remove_genre
    genre = params[:user][:genre].strip
    if genre.present?
      @user.genre_list.remove(genre)
      @user.save
      redirect_to dashboard_path, notice: "Genre removed successfully."
    else
      redirect_to dashboard_path, alert: "Genre cannot be empty."
    end
  end

  def add_artist
    artist = params[:artist].to_s.strip  # Ensure this matches the form input name

    if artist.present?
      @user.artist_list.add(artist)
      if @user.save
        redirect_to dashboard_path, notice: "Artist added successfully."
      else
        redirect_to dashboard_path, alert: "Failed to save user."
      end
    else
      redirect_to dashboard_path, alert: "Artist cannot be blank."
    end
  end

  def remove_artist
    artist = params[:user][:artist].to_s.strip  # Ensure this matches the form input name
    if artist.present?
      @user.artist_list.remove(artist)
      if @user.save
        redirect_to dashboard_path, notice: "Artist removed successfully."
      else
        redirect_to dashboard_path, alert: "Failed to save user."
      end
    else
      redirect_to dashboard_path, alert: "Artist cannot be blank."
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:genre, :artist)
  end

  # def filter_by_date(registered_gigs, time)
  #   case time
  #   when 'tonight'
  #     registered_gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
  #   when 'this_weekend'
  #     end_of_weekend = Time.zone.now.end_of_week(:monday)
  #     start_of_weekend = (end_of_weekend - 1.day).beginning_of_day
  #     registered_gigs.where('time >= ? AND time < ?', start_of_weekend, end_of_weekend)
  #   when 'this_month'
  #     registered_gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
  #   when 'next_month'
  #     start_of_next_month = Time.zone.now.next_month.beginning_of_month
  #     end_of_next_month = start_of_next_month.end_of_month
  #     registered_gigs.where('time >= ? AND time < ?', start_of_next_month, end_of_next_month)
  #   else
  #     registered_gigs
  #   end
  # end

  def set_devise_mapping
    @devise_mapping = Devise.mappings[:user]
  end

  def set_resource_class_and_name
    @resource_class = User
    @resource_name = :user
  end
end
