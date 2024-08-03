# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

Gig.destroy_all
puts "Destroying all gigs..."
User.destroy_all
puts "Destroying all users..."

address = ["Asakusa", "Shibuya", "Odaiba", "Shinjuku", "Ginza", "Meguro"]
gig_name = ["TomorrowLand", "Fuji Rock", "Lalapaloza"]
fan_user = User.create!(email: "fan@example.com", password: "123456")
band_user = User.create!(email: "band@example.com", password: "123456", is_band: true, band_name: "RockBand")

2.times do |i|
  Gig.create!(
    user: band_user,
    name: gig_name.sample,
    time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
    description: Faker::Lorem.paragraph,
    location: address.sample
  )
end

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"
