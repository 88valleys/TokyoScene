class AddGigIdToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :chatrooms, :gig_id, :bigint
    add_index :chatrooms, :gig_id
  end
end
