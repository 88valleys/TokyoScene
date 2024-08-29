class RenameTimeToTimeFromInGigs < ActiveRecord::Migration[7.1]
  def change
    rename_column :gigs, :time, :time_from
  end
end
