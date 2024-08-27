# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  content     :string
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :integer
#  user_id     :bigint           not null
#
# Indexes
#
#  index_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :chatroom
  has_one :gig, through: :chatroom
  belongs_to :user
end
