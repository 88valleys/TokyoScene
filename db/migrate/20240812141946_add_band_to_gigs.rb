class AddBandToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :band, :string
  end
end
