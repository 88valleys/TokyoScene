class Message < ApplicationRecord
  belongs_to :gig
  belongs_to :user
end
