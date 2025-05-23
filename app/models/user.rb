# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  band_genre             :string
#  band_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fav_genres             :string
#  is_band                :boolean          default(FALSE)
#  nickname               :string
#  profile_pic            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  spotify_access_token   :string
#  spotify_name           :string
#  spotify_refresh_token  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  spotify_id             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #   devise :database_authenticatable, :registerable,
  #          :recoverable, :rememberable, :validatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_taggable_on :genres
  acts_as_taggable_on :artists
  has_many :registrations
  has_many :gigs, through: :registrations
  has_many :artist_favourites
  has_many :artists, through: :artist_favourites
  has_many :chatrooms, through: :gigs
  has_one_attached :profile_pic

  def save_new_access_token(new_access_token)
    self.update(spotify_access_token: new_access_token)
    self.save
  end

  def spotify_accessible?
    return false if self.spotify_access_token.nil?
    return false if self.spotify_refresh_token.nil?

    true
  end

  # https://github.com/guilhermesad/rspotify
  def spotify_user
    RSpotify::User.new(
      {
        "credentials" => {
          "token" => self.spotify_access_token,
          "refresh_token" => self.spotify_refresh_token,
          "access_refresh_callback" => Proc.new { |new_access_token, token_lifetime|
            now = Time.now.utc.to_i
            deadline = now + token_lifetime
            self.save_new_access_token(new_access_token)
          },
          "id" => self.spotify_id,
        },
      }
    )
  end

  # https://developer.spotify.com/documentation/web-api/reference/get-users-top-artists-and-tracks
  def top_artists
    return [] unless spotify_accessible? && spotify_user.present?

    begin
      spotify_user.top_artists
    rescue
      []
    end
  end

  # https://developer.spotify.com/documentation/web-api/reference/get-users-top-artists-and-tracks
  def top_tracks
    return [] unless spotify_accessible?
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

    spotify_user.top_tracks
  end

  def playlist_count
    return 0 unless spotify_accessible?
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
    me = RSpotify::User.find("sssensss")
    me.playlists.count
  end

  # https://developer.spotify.com/documentation/web-api/reference/get-followed
  def following_artists
    return [] unless spotify_accessible?
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

    spotify_user.following(type: "artist")
  end

  def top_genres
    return [] unless spotify_accessible?
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

    # top_artists.map(&:genres).flatten
    self.top_artists.map { |a| a.genres }.flatten.uniq
  end

  def recommended_spotify_gigs
    return [] unless spotify_accessible?

    # Fetch recommended gigs based on user's genre list
    if self.top_genres.present?
      Gig.tagged_with(self.top_genres, any: true, wild: true)
    else
      []
    end
  end
end
