class Gig < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :genre
  has_one :chatroom, dependent: :destroy
  geocoded_by :location
  after_validation :geocode

  # Search form
  include PgSearch::Model
  pg_search_scope :search_by_name_and_location,

    against: [:event_name, :location, :band],

    against: [:event_name, :location,:band],

    using: {
      tsearch: { prefix: true },
    }

  has_many :registrations
  has_many :messages

  validates :band, :user, :location, presence: true

  # Gets the band's image from Spotify's API and places it in the Gig model
  def fetch_band_image
    # IMPORTANT: calls spotify_service.rb class which authenticates user and allows for image to be pulled from spotify's API
    band_info = SpotifyService.search_artist(self.band)
    if band_info && band_info["artists"] && band_info["artists"]["items"].any?
      self.band_image_url = band_info["artists"]["items"].first["images"].first["url"]
    else
      self.band_image_url = "https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg"
    end
  end

  def self.matching_event_names(event_names, genre)
    event_names.select do |event_name|
      genre.any? { |genre| event_name.downcase.include?(genre.downcase) }
    end
  end

  # geocoded_by :location
end
