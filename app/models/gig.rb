class Gig < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD

  # search form
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description_and_location,
  against: [ :name, :description, :location  ],
  using: {
    tsearch: { prefix: true }
  }
=======
  has_many :registrations
  has_many :messages

  validates :name, :time, :user, :location, presence: true
  
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
>>>>>>> 21dde632db1d1424fd440839c5a3bfa1f4942db4
end
