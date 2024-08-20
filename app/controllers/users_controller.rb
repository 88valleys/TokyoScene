class UsersController < ApplicationController
  before_action :set_user, only: [:dashboard, :add_genre, :remove_genre, :add_artist, :remove_artist, :show, :spotify]
  before_action :set_devise_mapping, only: [:dashboard]
  before_action :set_resource_class_and_name, only: [:dashboard]

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    @user = current_user
    @genres = ActsAsTaggableOn::Tag.for_context("genre")
    # @genres = ActsAsTaggableOn::Tag.all
    # Fetching all genres and artists for use in the dashboard
  end

  def registered_gigs
    @registered_gigs = current_user.registered_gigs
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

  # Spotify
  def spotify
    spotify_user = RSpotify::User.new(request.env["omniauth.auth"])
    # Now you can access user's private data, create playlists and much more

    # Access private data
    spotify_user.country #=> "US"
    spotify_user.email   #=> "example@email.com"

    # Create playlist in user's Spotify account
    playlist = spotify_user.create_playlist!("my-awesome-playlist")

    # Add tracks to a playlist in user's Spotify account
    tracks = RSpotify::Track.search("Know")
    playlist.add_tracks!(tracks)
    playlist.tracks.first.name #=> "Somebody That I Used To Know"

    # Access and modify user's music library
    spotify_user.save_tracks!(tracks)
    spotify_user.saved_tracks.size #=> 20
    spotify_user.remove_tracks!(tracks)

    albums = RSpotify::Album.search("launeddas")
    spotify_user.save_albums!(albums)
    spotify_user.saved_albums.size #=> 10
    spotify_user.remove_albums!(albums)

    # Use Spotify Follow features
    spotify_user.follow(playlist)
    spotify_user.follows?(artists)
    spotify_user.unfollow(users)

    # Get user's top played artists and tracks
    spotify_user.top_artists #=> (Artist array)
    spotify_user.top_tracks(time_range: "short_term") #=> (Track array)

    # Check doc for more
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:genre, :artist)
  end

  def set_devise_mapping
    @devise_mapping = Devise.mappings[:user]
  end

  def set_resource_class_and_name
    @resource_class = User
    @resource_name = :user
  end
end
