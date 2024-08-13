require 'faker'
Gig.destroy_all
User.destroy_all

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
  { band: 'Allen Stone', description: 'Soul singer', genre: 'Soul' },
  { band: 'Coldplay', description: 'Pop rock band', genre: 'Pop Rock' },
  { band: 'Snarky Puppy', description: 'Jazz fusion band', genre: 'Jazz Fusion' },
  { band: 'Mayer Hawthorne', description: 'Soul singer', genre: 'Soul' },
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
  { band: 'St. Paul and The Broken Bones', description: 'Soul band', genre: 'Soul' },
  { band: 'Elbow', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'TWICE', description: 'Girl group', genre: 'K-pop' },
  { band: 'Lianne La Havas', description: 'Soul singer-songwriter', genre: 'Soul' },
  { band: 'MAMAMOO', description: 'Girl group', genre: 'K-pop' },
  { band: 'The 1975', description: 'Pop rock band', genre: 'Pop Rock' },
  { band: 'Black Pumas', description: 'Psychedelic soul duo', genre: 'Psychedelic Soul' },
  { band: 'D’Angelo and The Vanguard', description: 'Neo-soul band', genre: 'Neo-Soul' },
  { band: 'Snow Patrol', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Stereophonics', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Nathaniel Rateliff & The Night Sweats', description: 'Soul and R&B band', genre: 'Soul' },
  { band: 'ITZY', description: 'Girl group', genre: 'K-pop' },
  { band: 'Keane', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Travis', description: 'Post-Britpop band', genre: 'Post-Britpop' },
  { band: 'The Internet', description: 'Soul and funk band', genre: 'Soul' },
  { band: 'Red Velvet', description: 'Girl group', genre: 'K-pop' },
  { band: 'The Verve', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Stray Kids', description: 'Boy band', genre: 'K-pop' },
  { band: 'Supergrass', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'Manic Street Preachers', description: 'Alternative rock band', genre: 'Alternative Rock' },
  { band: 'PinkPantheress', description: 'Bedroom pop singer', genre: 'Pop' }
]

40.times do |i|
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

