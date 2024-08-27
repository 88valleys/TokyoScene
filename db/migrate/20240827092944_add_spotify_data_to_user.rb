class AddSpotifyDataToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :spotify_name, :string
    add_column :users, :spotify_id, :string
    add_column :users, :spotify_access_token, :string
    add_column :users, :spotify_refresh_token, :string
  end
end
