class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #   devise :database_authenticatable, :registerable,
  #          :recoverable, :rememberable, :validatable

  # Omniauth for Spotify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[spotify]

  acts_as_taggable_on :genres
  acts_as_taggable_on :artists
  has_many :registrations
  has_many :gigs, through: :registrations
  has_many :artist_favourites
  has_many :artists, through: :artist_favourites
  has_many :chatrooms, through: :gigs
  has_one_attached :profile_pic

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.spotify_token = auth.credentials.token
      user.spotify_refresh_token = auth.credentials.refresh_token
      user.spotify_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

  # WIP: Spotify API integration
  def spotify_client
    @spotify_client ||= RSpotify::User.new("credentials" => {
                                             "token" => spotify_token, "refresh_token" => spotify_refresh_token, "expires_at" => spotify_expires_at.to_i,
                                           })
  end
end
