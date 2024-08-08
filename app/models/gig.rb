class Gig < ApplicationRecord
  belongs_to :user
  has_many :registrations
  has_many :messages

  validates :name, :time, :user, :location, presence: true
  
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
