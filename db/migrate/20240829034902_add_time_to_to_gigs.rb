class AddTimeToToGigs < ActiveRecord::Migration[7.1]
  def change
    add_column :gigs, :time_to, :datetime
  end
end
