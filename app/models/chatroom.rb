class Chatroom < ApplicationRecord
  belongs_to :gig  
  has_many :messages

end
