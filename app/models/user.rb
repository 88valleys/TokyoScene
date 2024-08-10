class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 8 Aug 2024 - commented out the previous master branch code just in case
         # has_many :gigs
  # has_many :registrations
  # has_many :messages
<<<<<<< HEAD
=======
  acts_as_taggable_on :genres

  has_many :registrations
  has_many :gigs, through: :registrations
>>>>>>> a5c11068814556050b00db249a691cc31afe1ec2
end
