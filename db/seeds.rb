require 'faker'
require 'open-uri'

Message.destroy_all
Chatroom.destroy_all
Registration.destroy_all
Gig.destroy_all
User.destroy_all

puts "Destroying all messages..."
puts "Destroying all chatrooms..."
puts "Destroying all registrations..."
puts "Destroying all gigs..."
puts "Destroying all users..."

address = ["Asakusa", "Shibuya", "Odaiba", "Shinjuku", "Ginza", "Meguro", "Akihabara", "Roppongi", "Harajuku", "Ikebukuro", "Ueno", "Yanaka", "Kichijoji", "Shimokitazawa", "Nakameguro", "Ebisu", "Koenji", "Ogikubo", "Setagaya", "Roppongi Hills", "Kagurazaka", "Jimbocho", "Yoyogi", "Nihonbashi", "Aoyama", "Shimo-Kitazawa", "Daikanyama", "Tokyo Station", "Ochanomizu", "Hongo", "Tsukiji", "Kappabashi", "Sangenjaya", "Tama"]

event_names = ["Sonic Splash", "Groove Blitz", "Echo Wave", "Riff Rampage", "Harmonic Pop", "Bass Boom", "Electro Surge", "Jam Buzz", "Rock Riot", "Folk Flick", "Melody Pop"]

bands = [
  { band: 'Red Velvet', description: 'Girl group', genre: 'K-pop' },
  { band: 'Arctic Monkeys', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Charles Bradley', description: 'Soul and funk singer', genre: 'Soul' },
  { band: 'Vulfpeck', description: 'Funk band', genre: 'Funk' },
  { band: 'The Kooks', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Trombone Shorty & Orleans Avenue', description: 'Funk and soul band', genre: 'Funk Soul' },
  { band: 'BTS', description: 'Boy band', genre: 'K-pop' },
  { band: 'Supergrass', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Coldplay', description: 'Pop rock band', genre: 'Pop Rock' },
  { band: 'Free Nationals', description: 'Soul and funk band', genre: 'Soul' },
  { band: 'NewJeans', description: 'Girl group', genre: 'K-pop' },
  { band: 'Franz Ferdinand', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Blur', description: 'Britpop band', genre: 'Britpop' },
  { band: 'The Beatles', description: 'Rock band', genre: 'Rock' },
  { band: 'Pulp', description: 'Britpop band', genre: 'Britpop' },
  { band: 'The Stone Roses', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Durand Jones & The Indications', description: 'Soul band', genre: 'Soul' },
  { band: 'EXO', description: 'Boy band', genre: 'K-pop' },
  { band: 'Cory Henry & The Funk Apostles', description: 'Funk and soul band', genre: 'Funk Soul' },
  { band: 'Thundercat', description: 'Bass guitarist and singer', genre: 'Funk' },
  { band: 'Kasabian', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Muse', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Emily King', description: 'Soul and R&B singer', genre: 'Soul' },
  { band: 'Sharon Jones & The Dap-Kings', description: 'Soul and funk band', genre: 'Soul' },
  { band: 'Bloc Party', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Lake Street Dive', description: 'Soul and pop band', genre: 'Soul Pop' },
  { band: 'Tank and The Bangas', description: 'Soul and funk band', genre: 'Funk Soul' },
  { band: 'Anderson .Paak', description: 'Rapper and singer', genre: 'R&B' },
  { band: 'The Libertines', description: 'Indie rock band', genre: 'Indie Rock' },
  { band: 'Oasis', description: 'Britpop band', genre: 'Britpop' },
  { band: 'Jungle', description: 'Modern soul collective', genre: 'Modern Soul' },
  { band: 'NCT 127', description: 'Boy band', genre: 'K-pop' },
  { band: 'Hiatus Kaiyote', description: 'Future soul band', genre: 'Future Soul' },
  { band: 'Radiohead', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Elbow', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'TWICE', description: 'Girl group', genre: 'K-pop' },
  { band: 'Lianne La Havas', description: 'Soul singer-songwriter', genre: 'Soul' },
  { band: 'MAMAMOO', description: 'Girl group', genre: 'K-pop' },
  { band: 'The 1975', description: 'Pop rock band', genre: 'Pop Rock' },
  { band: 'Black Pumas', description: 'Psychedelic soul duo', genre: 'Psychedelic Soul' },
  { band: 'D’Angelo and The Vanguard', description: 'Neo-soul band', genre: 'Neo-Soul' },
  { band: 'ITZY', description: 'Girl group', genre: 'K-pop' },
  { band: 'Keane', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'The Internet', description: 'Soul and funk band', genre: 'Soul' },
  { band: 'Red Velvet', description: 'Girl group', genre: 'K-pop' },
  { band: 'The Verve', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Stray Kids', description: 'Boy band', genre: 'K-pop' },
  { band: 'Supergrass', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'PinkPantheress', description: 'Bedroom pop singer', genre: 'Pop' },
  { band: 'His & Her Circumstances', description: 'Heart on your sleeve emo rock', genre: 'Emo Rock'}
]

# Method to generate a nickname based on the band name
def generate_nickname(band_name)
  band_name.split.map(&:first).join.upcase
end

# Create users for each band and store them in the bands array
bands.each do |band_info|
  email = Faker::Internet.unique.email
  user = User.create!(email: email, password: '123456', nickname: generate_nickname(band_info[:band]))
  band_info[:user] = user
  user.save!
end

10.times do |i|
  band_info = bands[i % bands.size]
  gig = Gig.create!(
    user: band_info[:user], # Associate the user with the gig
    band: band_info[:band],
    time: Faker::Date.between(from: Date.today, to: '2024-12-31'),
    description: band_info[:description],
    location: address.sample,
    event_name: event_names.sample
  )
  gig.genre_list.add(band_info[:genre])
  gig.save!
end

# Fetch all gigs
gigs = Gig.all

# Iterate over each gig and create a chatroom
gigs.each do |gig|
  chatroom = gig.build_chatroom(
    name: "#{gig.event_name} - #{gig.band}",
  )
  if chatroom.save
    puts "Chatroom created for gig: #{gig.event_name} - #{gig.band}"
  else
    puts "Failed to create chatroom for gig: #{gig.event_name} - #{gig.band}"
  end
end

# Create users and store them in an array
users = [
  { email: 'senie@senie.com', password: '123456', nickname: 'Senie' },
  { email: 'dianna@dianna.com', password: '123456', nickname: 'Dianna' },
  { email: 'yoosun@yoosun.com', password: '123456', nickname: 'Yoosun' },
  { email: 'erika@erika.com', password: '123456', nickname: 'Erika' }
]

# Create users, attaches profile photo and adds to the user
created_users = users.map do |user_data|
  user = User.create!(user_data)
  user_profile_pic = "https://picsum.photos/200/200?random=#{rand(1..1000)}"
  user.profile_pic.attach(io: URI.open(user_profile_pic), filename: "#{user_data[:nickname].downcase}.jpg")
  user
end

# Fetch the first and second gigs
first_gig = gigs.first
second_gig = gigs.second
third_gig = gigs.third

# Loop through each user and create registrations for both gigs
created_users.each do |user|
  Registration.create!(user_id: user.id, gig_id: first_gig.id)
  Registration.create!(user_id: user.id, gig_id: second_gig.id)
  Registration.create!(user_id: user.id, gig_id: third_gig.id)
end

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"
puts "Created #{Registration.count} registrations!"
