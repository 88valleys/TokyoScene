class AddColumsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_band, :boolean, default: false
    add_column :users, :band_name, :string
    add_column :users, :band_genre, :string
    add_column :users, :fav_genres, :string
  end
end
