require "faker"
require "open-uri"

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

address = [
  "Asakusa, Edo-dori Avenue, Kaminarimon 2-chome, Taito, Tokyo, 111-0034, Japan S",
  "Odaiba, ウエストプロムナード, Daiba 1-chome, Daiba, Minato, Tokyo, 135-8625, Japan",
  "Toho Cinemas, 1, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan ",
  "Ginza Six, 1, Ginza 6-chome, Chuo, Tokyo, 104-0061, Japan",
  "Asagaya, Star Road, Asagaya kita 2, Asagaya kita, Kōenji, Suginami, Tokyo, 166-0004, Japan Station ",
  "Akihabara Station, 6, Soto-Kanda 1-chome, 外神田, Chiyoda, Tokyo, 101-0021, Japan",
  "Roppongi Hills, Mafu Tunnel, Roppongi 6-chome, Roppongi, Azabu, Minato, Tokyo, 106-6122, Japan ",
  "Meiji Jingu Shrine, 1, Yoyogi Kamizono-chō, Shibuya, Tokyo, 151-8557, Japan",
  "Ikebukuro, 池袋駅 西武南口, Minami-Ikebukuro 1-chome, South Ikebukuro, Toshima, Tokyo, 171-8569, Japan",
  "Sangenjaya, Setagaya, Tokyo, 154-0024, Japan Quarter",
]

event_names = ["Sonic Splash", "Groove Blitz", "Echo Wave", "Riff Rampage", "Harmonic Pop", "Bass Boom", "Electro Surge", "Jam Buzz", "Rock Riot", "Folk Flick", "Melody Pop"].shuffle
bands = [
  { band: "Red Velvet", description: 'A powerhouse K-pop girl group known for their unique dual concept of "Red" (bright, bubbly pop) and "Velvet" (smooth R&B). Hits like "Red Flavor" and "Psycho" have solidified their global popularity.', genre: "K-pop" },
  { band: "Arctic Monkeys", description: 'British indie rock band hailing from Sheffield, known for their electrifying live performances and critically acclaimed albums like "AM" and "Whatever People Say I Am, Thats What Im Not".', genre: "Indie Rock" },
  { band: "Charles Bradley", description: 'Late-blooming soul sensation who rose to fame in his 60s with heart-wrenching performances and songs like "Changes". His gritty voice channels the raw emotion of classic soul.', genre: "Soul" },
  { band: "Vulfpeck", description: 'Funk band known for their tight grooves, minimalist approach, and playful live shows. Their song "Back Pocket" became a viral sensation, and they often experiment with live recording techniques.', genre: "Funk" },
  { band: "The Kooks", description: 'Indie rockers from Brighton, England, blending catchy guitar riffs and Britpop influences. Their debut album "Inside In/Inside Out" was a defining sound of the mid-2000s indie scene.', genre: "Indie Rock" },
  { band: "Trombone Shorty & Orleans Avenue", description: "A high-energy band from New Orleans, led by jazz and funk virtuoso Trombone Shorty. They blend jazz, funk, and hip-hop influences, bringing the sounds of New Orleans to the world stage.", genre: "Funk Soul" },
  { band: "BTS", description: 'Global K-pop phenomenon known for their tight choreography, deep lyricism, and social impact. BTS has topped charts worldwide with songs like "Dynamite" and "Butter", breaking countless records.', genre: "K-pop" },
  { band: "Supergrass", description: 'British alternative rock band famous for their catchy melodies and energetic sound. Their hit "Alright" became an anthem of the 90s Britpop era.', genre: "Alternative Rock" },
  { band: "Coldplay", description: 'British pop rock giants known for anthemic hits like "Yellow" and "Fix You". Their evolving sound has spanned from melancholic rock to electronic-infused pop.', genre: "Pop Rock" },
  { band: "Free Nationals", description: 'Anderson .Paaks backing band, combining soul, funk, and R&B to create a smooth, groovy sound. Known for their work on .Paaks albums and their solo work, including the hit "Beauty & Essex".', genre: "Soul" },
  { band: "NewJeans", description: 'Rising K-pop girl group known for their fresh, retro-inspired sound. Their debut tracks "Attention" and "Hype Boy" quickly catapulted them into stardom.', genre: "K-pop" },
  { band: "Franz Ferdinand", description: 'Scottish indie rock band known for their angular guitar riffs and dance-punk energy. Their breakout hit "Take Me Out" became a defining track of the 2000s indie scene.', genre: "Indie Rock" },
  { band: "Blur", description: 'Pioneers of the Britpop movement, Blur blended clever, observational lyrics with catchy melodies. Their hits like "Song 2" and "Parklife" defined the sound of 90s British music.', genre: "Britpop" },
  { band: "The Beatles", description: 'Arguably the most influential rock band of all time, The Beatles revolutionized music with their innovative songwriting and groundbreaking albums like "Sgt. Peppers" and "Abbey Road".', genre: "Rock" },
  { band: "Pulp", description: 'Icons of the Britpop era, Pulp brought wit, irony, and social commentary to their songs. Their anthem "Common People" remains a timeless classic of 90s UK music.', genre: "Britpop" },
  { band: "The Stone Roses", description: "Manchesters alternative rock legends who blended indie rock with dance rhythms. Their self-titled debut album is considered one of the greatest British albums of all time.", genre: "Alternative Rock" },
  { band: "Durand Jones & The Indications", description: "A soulful group that channels the vintage sounds of 60s and 70s soul, with a modern twist. Their heartfelt lyrics and retro grooves have won them a dedicated following.", genre: "Soul" },
  { band: "EXO", description: 'One of K-pops biggest boy bands, EXO is known for their harmonious vocals, synchronized choreography, and hits like "Growl" and "Love Shot" that have captivated fans worldwide.', genre: "K-pop" },
  { band: "Cory Henry & The Funk Apostles", description: "Led by virtuoso keyboardist Cory Henry, this band blends funk, soul, and gospel, delivering electrifying performances filled with tight grooves and powerful vocals.", genre: "Funk Soul" },
  { band: "Thundercat", description: "Grammy-winning bassist and singer who fuses jazz, funk, and electronic music. His virtuosic bass playing and quirky persona have earned him a cult following in modern music.", genre: "Funk" },
  { band: "Kasabian", description: 'Indie rock giants from Leicester, known for their anthemic sound and energetic live shows. Hits like "Fire" and "Club Foot" have become festival favorites.', genre: "Indie Rock" },
  { band: "Muse", description: 'British alternative rock band known for their epic, operatic sound and futuristic themes. Albums like "Absolution" and "The Resistance" pushed the boundaries of modern rock.', genre: "Alternative Rock" },
  { band: "Emily King", description: 'Soulful singer-songwriter blending R&B, pop, and jazz influences. Her smooth vocals and introspective songwriting shine on albums like "Scenery" and "The Switch".', genre: "Soul" },
  { band: "Sharon Jones & The Dap-Kings", description: "Soul revivalists who captured the raw, gritty energy of 60s and 70s funk and soul. Sharon Jones powerhouse voice drove the bands sound, making them a staple of the genre.", genre: "Soul" },
  { band: "Bloc Party", description: 'British indie rock band known for their angular guitar riffs, driving rhythms, and politically charged lyrics. Their debut album "Silent Alarm" is considered a modern classic.', genre: "Indie Rock" },
  { band: "Lake Street Dive", description: 'Genre-bending band combining soul, pop, and jazz. Lead singer Rachael Prices powerful vocals are the highlight of their eclectic sound, showcased in hits like "Good Kisser".', genre: "Soul Pop" },
  { band: "Tank and The Bangas", description: 'New Orleans-based band blending funk, soul, hip-hop, and spoken word. Frontwoman Tarriona "Tank" Balls theatrical energy has earned the band critical acclaim and a loyal fanbase.', genre: "Funk Soul" },
  { band: "Anderson .Paak", description: 'Multi-talented rapper, singer, and drummer who blends R&B, hip-hop, and funk. His raspy vocals and infectious grooves on tracks like "Come Down" have made him a genre-defying star.', genre: "R&B" },
  { band: "The Libertines", description: "UK indie rockers known for their raw energy and chaotic live performances. Led by Pete Doherty and Carl Barât, their influence on the British indie scene is undeniable.", genre: "Indie Rock" },
  { band: "Oasis", description: 'Britpop legends whose anthems "Wonderwall" and "Dont Look Back in Anger" defined a generation. Oasis swaggering sound and larger-than-life attitude made them global rock icons.', genre: "Britpop" },
  { band: "Jungle", description: 'London-based modern soul collective known for their smooth, groove-heavy sound and atmospheric music videos. Tracks like "Busy Earnin" capture their unique blend of funk, soul, and electronic.', genre: "Modern Soul" },
  { band: "NCT 127", description: 'K-pop boy band with a diverse, experimental sound that blends hip-hop, pop, and R&B. Known for their energetic performances and hits like "Cherry Bomb" and "Kick It".', genre: "K-pop" },
  { band: "Hiatus Kaiyote", description: "Australian future soul band blending jazz, soul, and electronic music. Their unconventional sound and intricate compositions have earned them a global cult following.", genre: "Future Soul" },
  { band: "Radiohead", description: 'Pioneers of experimental rock, known for pushing boundaries with their innovative sound. Albums like "OK Computer" and "Kid A" redefined alternative rock for a new generation.', genre: "Alternative Rock" },
  { band: "Elbow", description: 'British alternative rock band known for their orchestral sound and poetic lyrics. Tracks like "One Day Like This" and "Grounds for Divorce" showcase their anthemic, yet intimate style.', genre: "Alternative Rock" },
  { band: "TWICE", description: 'K-pop girl group known for their catchy hooks, vibrant visuals, and energetic performances. Hits like "TT" and "Fancy" have made them one of the most popular acts in K-pop.', genre: "K-pop" },
  { band: "Lianne La Havas", description: 'British singer-songwriter blending soul, folk, and jazz influences. Her emotive voice and introspective lyrics shine in albums like "Blood" and her self-titled "Lianne La Havas".', genre: "Soul" },
  { band: "MAMAMOO", description: 'Charismatic K-pop girl group known for their powerful vocals and bold performances. Their genre-blending sound spans pop, R&B, and jazz, with hits like "HIP" and "Starry Night".', genre: "K-pop" },
  { band: "The 1975", description: "British pop rock band with a penchant for blending 80s pop, indie rock, and electronica. Fronted by the enigmatic Matty Healy, theyve gained a cult following for their eclectic sound.", genre: "Pop Rock" },
  { band: "Black Pumas", description: 'Austin-based psychedelic soul duo known for their soulful, vintage-inspired sound. Their hit "Colors" has earned them widespread acclaim and Grammy nominations.', genre: "Psychedelic Soul" },
  { band: "DAngelo and The Vanguard", description: 'Neo-soul pioneers who redefined the genre with their sultry grooves and socially conscious lyrics. Their album "Black Messiah" is a modern classic in soul and R&B.', genre: "Neo-Soul" },
  { band: "ITZY", description: 'K-pop girl group with a rebellious, empowering message and bold choreography. Known for hits like "Dalla Dalla" and "Wannabe", they are quickly rising in the global K-pop scene.', genre: "K-pop" },
  { band: "Keane", description: 'British alternative rock band known for their piano-driven sound and melancholic lyrics. Their debut album "Hopes and Fears" includes hits like "Somewhere Only We Know".', genre: "Alternative Rock" },
  { band: "The Internet", description: 'Soul and funk collective blending R&B, jazz, and hip-hop. Fronted by Syd, their smooth, laid-back grooves can be heard on tracks like "Girl" and "Come Over".', genre: "Soul" },
  { band: "The Verve", description: 'British alternative rock band known for their sweeping soundscapes and hit single "Bitter Sweet Symphony", which became one of the most iconic tracks of the 90s.', genre: "Alternative Rock" },
  { band: "Stray Kids", description: 'Self-producing K-pop boy band known for their hard-hitting, experimental sound. Songs like "Gods Menu" showcase their powerful energy and genre-bending style.', genre: "K-pop" },
  { band: "Supergrass", description: 'British alternative rock band famed for their energetic live shows and catchy tunes. Their hit "Alright" became synonymous with the youthful exuberance of the Britpop era.', genre: "Alternative Rock" },
  { band: "PinkPantheress", description: 'Bedroom pop artist blending nostalgic 2000s sounds with a modern twist. Her viral hits like "Pain" and "Just for Me" have resonated with a new generation of pop fans.', genre: "Pop" },
  { band: "His & Her Circumstances", description: "Emotional rock band whose music embraces vulnerability and catharsis, delivering heartfelt, introspective lyrics with raw, emo-infused energy.", genre: "Emo Rock" },
]

# Method to generate a nickname based on the band name
def generate_nickname(band_name)
  band_name.split.map(&:first).join.upcase
end

# Create users for each band and store them in the bands array
bands.each do |band_info|
  email = Faker::Internet.unique.email
  user = User.create!(email: email, password: "123456", nickname: generate_nickname(band_info[:band]))
  band_info[:user] = user
  user.save!
end

# Create gigs for 20 bands
20.times do |i|
  band_info = bands.sample # Randomly select a band from the array
  gig = Gig.create!(
    user: band_info[:user], # Associate the user with the gig
    band: band_info[:band],
    time: Faker::Date.between(from: Date.today, to: 30.days.from_now),
    description: band_info[:description],
    location: address.sample, # Use the random address
    event_name: event_names.sample,
    # genre: band[:genre],
  )
  gig.genre_list.add(band_info[:genre])
  gig.save!
end

# Add one more gig for tonight
band_info = bands.sample
tonight_gig = Gig.create!(
  user: band_info[:user],
  band: band_info[:band],
  time: Date.today, # Set the time to today
  description: band_info[:description],
  location: address.sample, # Use the random address
  event_name: event_names.sample,
)
tonight_gig.genre_list.add(band_info[:genre])
tonight_gig.save!


# Fetch all gigs
gigs = Gig.all

# Iterate over each gig and create a chatroom
gigs.each do |gig|
  chatroom = gig.build_chatroom(
    name: "#{gig.event_name}: #{gig.band}",
  )
  if chatroom.save
    puts "Chatroom created for gig: #{gig.event_name} - #{gig.band}"
  else
    puts "Failed to create chatroom for gig: #{gig.event_name} - #{gig.band}"
  end
end

# Create users and store them in an array
users = [
  { email: "senie@senie.com", password: "123456", nickname: "Senie" },
  { email: "dianna@dianna.com", password: "123456", nickname: "Dianna" },
  { email: "yoosun@yoosun.com", password: "123456", nickname: "Yoosun" },
  { email: "erika@erika.com", password: "123456", nickname: "Erika" },
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
