class Gig < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :genre
  has_one :chatroom, dependent: :destroy
  geocoded_by :location
  after_validation :geocode

  # search form
  include PgSearch::Model
  pg_search_scope :search_by_name_and_location,
    against: [:event_name, :location],
    using: {
      tsearch: { prefix: true }
    }

  has_many :registrations
  has_many :messages

  validates :band, :time, :user, :location, presence: true

  # Gets the band's image from Spotify's API and places it in the Gig model

  def fetch_band_image
    # IMPORTANT: calls spotify_service.rb class which authenticates user and allows for image to be pulled from spotify's API
    band_info = SpotifyService.search_artist(self.band)
    if band_info && band_info['artists'] && band_info['artists']['items'].any?
      self.band_image_url = band_info['artists']['items'].first['images'].first['url']
    else
      self.band_image_url = 'https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg'
    end
  end

  # geocoded_by :location

end
