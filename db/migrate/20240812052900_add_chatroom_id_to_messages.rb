class AddChatroomIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :chatroom_id, :integer
  end
end
