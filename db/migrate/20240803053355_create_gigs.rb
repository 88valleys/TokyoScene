class CreateGigs < ActiveRecord::Migration[7.1]
  def change
    create_table :gigs do |t|
      t.string :name
      t.date :time
      t.text :description
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
