class AddCoordinatesToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :latitude, :float
    add_column :gigs, :longitude, :float
  end
end
