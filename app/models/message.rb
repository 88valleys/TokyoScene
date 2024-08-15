class Message < ApplicationRecord
  belongs_to :chatroom
  has_one :gig, through: :chatroom
  belongs_to :user
end
