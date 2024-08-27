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
class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :gig
  
  enum status: { pending: 0, accepted: 1, canceled: 2, waitlisted: 3 }

  delegate :chatroom, to: :gig
end
