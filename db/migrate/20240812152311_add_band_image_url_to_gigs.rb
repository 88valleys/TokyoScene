class AddBandImageUrlToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :band_image_url, :string
  end
end
