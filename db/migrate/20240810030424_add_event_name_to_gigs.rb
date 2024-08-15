class AddEventNameToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :event_name, :string
  end
end
