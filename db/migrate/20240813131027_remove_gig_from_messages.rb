class RemoveGigFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_reference :messages, :gig, null: false, foreign_key: true
  end
end
