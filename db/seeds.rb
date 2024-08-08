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

address = ["Asakusa", "Shibuya", "Odaiba", "Shinjuku", "Ginza", "Meguro"]
genre = ["Rock", "Indie"]

10.times do |i|
  user = User.create!(email: "user-#{i + 1}@example.com", password: "123456")
  Gig.create!(
    user: user,
    name: Faker::Music::RockBand.name,
    time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
    genre: genre.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    location: address.sample
  )
end

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"
