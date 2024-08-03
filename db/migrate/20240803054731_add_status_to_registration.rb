class AddStatusToRegistration < ActiveRecord::Migration[7.1]
  def change
    add_column :registrations, :status, :integer
  end
end
