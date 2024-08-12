# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

# require 'faker'
# Gig.destroy_all
# User.destroy_all

# puts "Destroying all gigs..."
# puts "Destroying all users..."

# address = ["Asakusa", "Shibuya", "Odaiba", "Shinjuku", "Ginza", "Meguro"]
# genre = ["Rock", "Indie", "Emo", "Grunge", "Electronic"]
# event_names = [
#   "Sonic Surge Festival",
#   "Groove Junction",
#   "Echoes of the Underground",
#   "Riff & Rhythm Riot",
#   "Harmonic Haven",
#   "Bassline Blitz",
#   "Electro Vibes Night",
#   "Jazz & Jam Sessions",
#   "Rock the Block",
#   "Folk Fusion Fest",
#   "Melody & Mayhem"
# ]

# 30.times do |i|
#   user = User.create!(email: "user-#{i + 1}@example.com", password: "123456")
#   gig = Gig.create!(
#     user: user,
#     band: Faker::Music::RockBand.name,
#     time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
#     description: Faker::Quotes::Shakespeare.hamlet_quote,
#     location: address.sample,
#     event_name: event_names.sample
#   )
#   gig.genre_list.add(genre.sample)
#   gig.save!
# end

# user = User.create!(email: "senie@senie.com", password: "123456")

# # Sample gig for H&HC
# Gig.create!(
#   user: user,
#   band: "H&HC",
#   time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
#   description: "Heart on your sleeve emo rock",
#   location: "Budoukan",
#   event_name: event_names.sample

# )

# puts "Created #{User.count} users!"
# puts "Created #{Gig.count} gigs!"

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

address = ["Asakusa", "Shibuya", "Odaiba", "Shinjuku", "Ginza", "Meguro", "Akihabara", "Roppongi", "Harajuku", "Ikebukuro", "Ueno", "Yanaka", "Kichijoji", "Shimokitazawa"]


event_names = ["Sonic Surge Festival", "Groove Junction", "Echoes of the Underground", "Riff & Rhythm Riot", "Harmonic Haven", "Bassline Blitz", "Electro Vibes Night", "Jazz & Jam Sessions", "Rock the Block", "Folk Fusion Fest", "Melody & Mayhem"]

bands = [
  { band: 'Radiohead', description: 'Alternative rock band', location: 'Oxford, England', genre: 'Alternative Rock' },
  { band: 'Free Nationals', description: 'Soul and funk band', location: 'Los Angeles, California', genre: 'Soul' },
  { band: 'Coldplay', description: 'Pop rock band', location: 'London, England', genre: 'Pop Rock' },
  { band: 'Anderson .Paak', description: 'Rapper and singer', location: 'Oxnard, California', genre: 'R&B' },
  { band: 'The Beatles', description: 'Rock band', location: 'Liverpool, England', genre: 'Rock' },
  { band: 'The Internet', description: 'Soul and funk band', location: 'Los Angeles, California', genre: 'Soul' },
  { band: 'Oasis', description: 'Britpop band', location: 'Manchester, England', genre: 'Britpop' },
  { band: 'Hiatus Kaiyote', description: 'Future soul band', location: 'Melbourne, Australia', genre: 'Future Soul' },
  { band: 'Blur', description: 'Britpop band', location: 'London, England', genre: 'Britpop' },
  { band: 'D’Angelo and The Vanguard', description: 'Neo-soul band', location: 'Richmond, Virginia', genre: 'Neo-Soul' },
  { band: 'Arctic Monkeys', description: 'Indie rock band', location: 'Sheffield, England', genre: 'Indie Rock' },
  { band: 'Jungle', description: 'Modern soul collective', location: 'London, England', genre: 'Modern Soul' },
  { band: 'The Smiths', description: 'Alternative rock band', location: 'Manchester, England', genre: 'Alternative Rock' },
  { band: 'Vulfpeck', description: 'Funk band', location: 'Ann Arbor, Michigan', genre: 'Funk' },
  { band: 'The Stone Roses', description: 'Alternative rock band', location: 'Manchester, England', genre: 'Alternative Rock' },
  { band: 'Snarky Puppy', description: 'Jazz fusion band', location: 'Brooklyn, New York', genre: 'Jazz Fusion' },
  { band: 'The Verve', description: 'Alternative rock band', location: 'Wigan, England', genre: 'Alternative Rock' },
  { band: 'Lianne La Havas', description: 'Soul singer-songwriter', location: 'London, England', genre: 'Soul' },
  { band: 'Kasabian', description: 'Indie rock band', location: 'Leicester, England', genre: 'Indie Rock' },
  { band: 'Thundercat', description: 'Bass guitarist and singer', location: 'Los Angeles, California', genre: 'Funk' },
  { band: 'Muse', description: 'Alternative rock band', location: 'Teignmouth, England', genre: 'Alternative Rock' },
  { band: 'Leon Bridges', description: 'Soul singer', location: 'Fort Worth, Texas', genre: 'Soul' },
  { band: 'Snow Patrol', description: 'Alternative rock band', location: 'Dundee, Scotland', genre: 'Alternative Rock' },
  { band: 'Charles Bradley', description: 'Soul and funk singer', location: 'Brooklyn, New York', genre: 'Soul' },
  { band: 'Elbow', description: 'Alternative rock band', location: 'Bury, England', genre: 'Alternative Rock' },
  { band: 'Nathaniel Rateliff & The Night Sweats', description: 'Soul and R&B band', location: 'Denver, Colorado', genre: 'Soul' },
  { band: 'Travis', description: 'Post-Britpop band', location: 'Glasgow, Scotland', genre: 'Post-Britpop' },
  { band: 'Alabama Shakes', description: 'Soul and rock band', location: 'Athens, Alabama', genre: 'Soul Rock' },
  { band: 'Keane', description: 'Alternative rock band', location: 'Battle, England', genre: 'Alternative Rock' },
  { band: 'St. Paul and The Broken Bones', description: 'Soul band', location: 'Birmingham, Alabama', genre: 'Soul' },
  { band: 'The Libertines', description: 'Indie rock band', location: 'London, England', genre: 'Indie Rock' },
  { band: 'Durand Jones & The Indications', description: 'Soul band', location: 'Bloomington, Indiana', genre: 'Soul' },
  { band: 'Supergrass', description: 'Alternative rock band', location: 'Oxford, England', genre: 'Alternative Rock' },
  { band: 'Black Pumas', description: 'Psychedelic soul duo', location: 'Austin, Texas', genre: 'Psychedelic Soul' },
  { band: 'Pulp', description: 'Britpop band', location: 'Sheffield, England', genre: 'Britpop' },
  { band: 'Allen Stone', description: 'Soul singer', location: 'Chewelah, Washington', genre: 'Soul' },
  { band: 'Franz Ferdinand', description: 'Indie rock band', location: 'Glasgow, Scotland', genre: 'Indie Rock' },
  { band: 'Lake Street Dive', description: 'Soul and pop band', location: 'Boston, Massachusetts', genre: 'Soul Pop' },
  { band: 'Bloc Party', description: 'Indie rock band', location: 'London, England', genre: 'Indie Rock' },
  { band: 'Trombone Shorty & Orleans Avenue', description: 'Funk and soul band', location: 'New Orleans, Louisiana', genre: 'Funk Soul' },
  { band: 'The Charlatans', description: 'Alternative rock band', location: 'West Midlands, England', genre: 'Alternative Rock' },
  { band: 'Tank and The Bangas', description: 'Soul and funk band', location: 'New Orleans, Louisiana', genre: 'Funk Soul' },
  { band: 'Manic Street Preachers', description: 'Alternative rock band', location: 'Blackwood, Wales', genre: 'Alternative Rock' },
  { band: 'Mayer Hawthorne', description: 'Soul singer', location: 'Ann Arbor, Michigan', genre: 'Soul' },
  { band: 'The 1975', description: 'Pop rock band', location: 'Manchester, England', genre: 'Pop Rock' },
  { band: 'Sharon Jones & The Dap-Kings', description: 'Soul and funk band', location: 'Brooklyn, New York', genre: 'Soul' },
  { band: 'Stereophonics', description: 'Alternative rock band', location: 'Cwmaman, Wales', genre: 'Alternative Rock' },
  { band: 'Cory Henry & The Funk Apostles', description: 'Funk and soul band', location: 'Brooklyn, New York', genre: 'Funk Soul' },
  { band: 'The Kooks', description: 'Indie rock band', location: 'Brighton, England', genre: 'Indie Rock' },
  { band: 'Emily King', description: 'Soul and R&B singer', location: 'New York, New York', genre: 'Soul' }
]

30.times do |i|
  user = User.create!(email: "user-#{i + 1}@example.com", password: "123456")
  band_info = bands[i % bands.size]
  gig = Gig.create!(
    user: user,
    band: band_info[:band],
    time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
    description: band_info[:description],
    location: address.sample,
    event_name: event_names.sample
  )
  gig.genre_list.add(band_info[:genre])
  gig.save!
end

user = User.create!(email: "senie@senie.com", password: "123456")

# Sample gig for H&HC
Gig.create!(
  user: user,
  band: "His & Her Circumstances",
  time: Faker::Date.between(from: Date.today, to: '2025-12-31'),
  description: "Heart on your sleeve emo rock",
  location: "Budoukan",
  event_name: event_names.sample,
  genre_list: "Emo Rock"
)

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"

