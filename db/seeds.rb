# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
Gig.destroy_all
User.destroy_all

puts "Destroying all gigs..."
puts "Destroying all users..."

# TODO: change the content of the array to that contains "shibuya" something like that
address = [
  "150-0042 Udagawacho, Shibuya ku, Tokyo to",
  "160-0021 Kabukichou, Shinjuku ku, Tokyo to",
  "166-0003, Koenji, Suginami ku, Tokyo to",
  "155-0031, Shimokitazawa, Setagaya ku, Tokyo to",
  "166-0001, Asagaya, Suginami ku, Tokyo to",
  "153-0064, Meguro, Meguro ku, Tokyo to"
  ]
genre = ["Rock", "Indie", "Emo", "Grunge", "Electronic"]

10.times do |i|
  user = User.create!(email: "user-#{i + 1}@example.com", password: "123456")
  gig = Gig.create!(
    user: user,
    name: Faker::Music::RockBand.name,
    time: Faker::Time.forward(days: 23, period: :evening),
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    location: address.sample
  )
  gig.genre_list.add(genre.sample)
  gig.save!
end

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"
