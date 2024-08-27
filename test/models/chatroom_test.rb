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
require "test_helper"

class ChatroomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
