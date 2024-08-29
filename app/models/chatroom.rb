# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gig_id     :bigint
#
# Indexes
#
#  index_chatrooms_on_gig_id  (gig_id)
#
class Chatroom < ApplicationRecord
  belongs_to :gig  
  has_many :messages

end
