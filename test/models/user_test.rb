# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  band_genre             :string
#  band_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fav_genres             :string
#  is_band                :boolean          default(FALSE)
#  nickname               :string
#  profile_pic            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  spotify_access_token   :string
#  spotify_name           :string
#  spotify_refresh_token  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  spotify_id             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
