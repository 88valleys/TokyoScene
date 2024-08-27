# == Schema Information
#
# Table name: gigs
#
#  id             :bigint           not null, primary key
#  band           :string
#  band_image_url :string
#  description    :text
#  event_name     :string
#  genre          :string
#  latitude       :float
#  location       :string
#  location_name  :string
#  longitude      :float
#  name           :string
#  time           :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_gigs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class GigTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
