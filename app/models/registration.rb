class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :gig
  enum status: { pending: 0, accepted: 1, canceled: 2, waitlisted: 3 }
end
