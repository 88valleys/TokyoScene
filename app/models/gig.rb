class Gig < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :genre

  # search form
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description_and_location,
  against: [ :name, :description, :location  ],
  using: {
    tsearch: { prefix: true }
  }
  has_many :registrations
  has_many :messages

  validates :name, :time, :user, :location, presence: true

  # geocoded_by :location

  before_create :set_geocode
  # after_validation :geocode, if: :will_save_change_to_location?

  def set_geocode
    self.longitude = 139.76430559879972
    self.latitude = 35.66951555
  end
end
