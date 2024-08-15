class ChangeTimeToDatetimeInGigs < ActiveRecord::Migration[7.1]
  def change
    change_column :gigs, :time, :datetime
  end
end
