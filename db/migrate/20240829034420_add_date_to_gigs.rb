class AddDateToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :date, :datetime
  end
end
