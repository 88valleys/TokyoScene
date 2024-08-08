class Gig < ApplicationRecord
  belongs_to :user

  # search form
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description_and_location,
  against: [ :name, :description, :location  ],
  using: {
    tsearch: { prefix: true }
  }
end
