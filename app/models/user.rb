class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 8 Aug 2024 - commented out the previous master branch code just in case
         # has_many :gigs
  # has_many :registrations
  # has_many :messages
end
