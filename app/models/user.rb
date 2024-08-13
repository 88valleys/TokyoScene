class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 8 Aug 2024 - commented out the previous master branch code just in case
         # has_many :gigs
  # has_many :registrations
  # has_many :messages
  acts_as_taggable_on :genres
  acts_as_taggable_on :artists
  has_many :registrations
  has_many :gigs, through: :registrations
  has_many :artist_favourites
  has_many :artists, through: :artist_favourites
end
