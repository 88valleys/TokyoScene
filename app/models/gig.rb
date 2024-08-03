class Gig < ApplicationRecord
  belongs_to :user
  has_many :registrations
  has_many :messages

  validates :name, :time, :user, :location, presence: true


end
