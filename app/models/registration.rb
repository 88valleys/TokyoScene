class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :gig

  enum :status, { pending: 0, accepted: 1, cancelled: 2, waitlist: 3 }
end
