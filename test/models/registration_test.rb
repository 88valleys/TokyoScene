# == Schema Information
#
# Table name: registrations
#
#  id         :bigint           not null, primary key
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gig_id     :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_registrations_on_gig_id   (gig_id)
#  index_registrations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (gig_id => gigs.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
