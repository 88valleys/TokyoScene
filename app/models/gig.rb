
class Gig < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :genre

  # search form
  include PgSearch::Model
  pg_search_scope :search_by_band_and_description_and_location,
  against: [ :band, :description, :location  ],
  using: {
    tsearch: { prefix: true }
  }
  has_many :registrations
  has_many :messages

  validates :band, :time, :user, :location, presence: true

  # Gets the band's image from Spotify's API and places it in the Gig model

  def fetch_band_image
    band_info = RSpotify::Artist.search(self.band).first
    if band_info && band_info.images.any?
      self.band_image_url = band_info.images.first['url']
    else
      self.band_image_url = 'https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/skateboard.jpg'
    end
  end

  # geocoded_by :location

  before_create :set_geocode
  # after_validation :geocode, if: :will_save_change_to_location?

  def set_geocode
    self.longitude = 139.76430559879972
    self.latitude = 35.66951555
  end
end
