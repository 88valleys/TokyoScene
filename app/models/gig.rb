class Gig < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :genre

  # search form
  include PgSearch::Model

  pg_search_scope :search_by_name_and_location,
  against: [ :name, :location ],
  using: {
    tsearch: { prefix: true } # Allows partial matching (e.g., "search" will match "search", "searched", "searching")
  }

  has_many :registrations
  has_many :messages

  validates :name, :time, :user, :location, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
