class AddProfilePicToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :profile_pic, :string
  end
end
