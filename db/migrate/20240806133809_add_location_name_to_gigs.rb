class AddLocationNameToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :location_name, :string
  end
end
