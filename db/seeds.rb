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

livehouses = [
  # Shibuya
  { livehouse: "Axxcis-Club Axxcis SHINJUKU", address: "Hanamichi-dori Street, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  { livehouse: "Circus Tokyo, Shibuya", address: "16, Shibuya 3, Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Club Asia, Shibuya", address: "Rambling Street, Maruyamacho, Shibuya, Tokyo, 155-0002, Japan" },
  { livehouse: "Contact, Shibuya", address: "12, Dogen-zaka Street, Dogenzaka 2, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Cyclone, Shibuya", address: "Penguin Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "Daitokai, Matsudo", address: "Matsudo Station Line, 本町, Matsudo, Chiba Prefecture, 271-0091, Japan" },
  { livehouse: "DUO Music Exchange, Shibuya", address: "Rambling Street, Maruyamacho, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "FabCafe, Shibuya", address: "1-22-7, Dogen-zaka Street, Maruyamacho, Shibuya, Tokyo, 150-0044, Japan" },
  { livehouse: "Galaxy (Shibuya)", address: "5-27-7, Cat Street, Jingumae 6, Jingūmae, Shibuya, Tokyo, 150-0001, Japan" },
  { livehouse: "Hobgoblin, Shibuya", address: "Omoide-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Home, Shibuya", address: "Nakasugi-dori Avenue, Saginomiya 4-chome, Nakano, Tokyo, 165-0032, Japan" },
  { livehouse: "Image Forum, Shibuya", address: "Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Kitsune, Shibuya", address: "2-20-13, Meiji-dori Avenue, Higashi, Higashi 2, Higashi, Shibuya, Tokyo, 150-0011, Japan" },
  { livehouse: "La Mama, Shibuya", address: "Shibuya Chuo-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Line Cube Shibuya", address: "1, Udagawacho, Shibuya, Tokyo, 150-0771, Japan" },
  { livehouse: "Lush, Shibuya", address: "6, Shinjuku 3, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Music Bar 45, Shibuya", address: "Sakuragaokacho, Shibuya, Tokyo, 150-0031, Japan" },
  { livehouse: "NHK Hall, Shibuya", address: "1, Jinnan 2, Jinnan, Shibuya, Tokyo, 150-8001, Japan" },
  { livehouse: "NIGHTFLY, Shibuya", address: "Udagawacho, Shibuya, Tokyo, 150-8507, Japan" },
  { livehouse: "Oath, Shibuya", address: "9, Shibuya 4, Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Sankeys TYO, Shibuya", address: "Sarugakucho, Shibuya, Tokyo, 150-0033, Japan" },
  { livehouse: "Shibuya Ax, Shibuya", address: "Wave-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "SHIBUYA REX, Shibuya", address: "Miyamasu-zaka Street, Shibuya 2, Shibuya, Tokyo, 150-8510, Japan" },
  { livehouse: "The Aldgate, Shibuya", address: "Shibuya Center-gai Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "The Room, Shibuya", address: "15-19, Sakuragaokacho, Shibuya, Tokyo, 150-0031, Japan" },
  { livehouse: "Tower Records Shibuya", address: "14, Jinnan 1, Jinnan, Shibuya, Tokyo, 150-0041, Japan" },
  { livehouse: "Womb, Shibuya", address: "16, Maruyamacho, Shibuya, Tokyo, 150-0044, Japan" },
  { livehouse: "WWW, Shibuya", address: "Spain-zaka Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "翠月 (MITSUKI), Shibuya", address: "Dogen-zaka Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0044, Japan" },
  # Asakusa
  { livehouse: "Cuzn Homeground, Asakusa", address: "Hisago-dori, Asakusa 2-chome, Asakusa, Taito, Tokyo, 111-0032, Japan" },
  { livehouse: "Infinity Books, Asakusa", address: "Asakusa-dori, Azumabashi 1, Azumabashi, Sumida, Tokyo, 130-0001, Japan" },
  # Shinjuku
  { livehouse: "8bit cafe, Shinjuku", address: "御苑通り, Shinjuku 2, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Antiknock, Shinjuku", address: "Meiji-dori Avenue, Shinjuku 4, Shinjuku, Tokyo, 151-8580, Japan" },
  { livehouse: "Cafe Lavanderia, Shinjuku", address: "新宿2-12-9, Hanazono-dori, Shinjuku 2, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Christon Cafè, Shinjuku", address: "Yasukuni-dori Avenue, Shinjuku 5, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Marz, Shinjuku", address: "Ichiban-dori Street, Kabukicho 2, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  { livehouse: "Rosso, Shinjuku", address: "4C's Bar Rosso, 1, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  { livehouse: "Spincoaster, Shinjuku", address: "四谷角筈線, Yoyogi 2, Yoyogi, Nishi Shinjuku, Shibuya, Tokyo, 151-8583, Japan" },
  { livehouse: "Tokyo Opera City, Shinjuku", address: "Yamate-dori Avenue, Honmachi 3, Nishi Shinjuku 3, Nishi Shinjuku, Shinjuku, Tokyo, 151-0071, Japan" },
  { livehouse: "Tower Records Shinjuku", address: "1, Shinjuku 3, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Wild Side Tokyo, Shinjuku", address: "Yasukuni-dori, Shinjuku 5, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Zirco Tokyo, Shinjuku", address: "Kuyakusho-dori Avenue, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  # Asagaya
  { livehouse: "mogumogu Asagaya", address: "Pearl Center Shika, Asagaya Pearl Center Shopping Street, Asagaya minami 1, Asagaya minami, Kōenji, Suginami, Tokyo, 166-8578" },
  { livehouse: "Gamuso, Asagaya", address: "Asagaya kita 2, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Art Bar Ten, Asagaya", address: "Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  { livehouse: "COOL DREAD BAR, Asagaya", address: "Asagaya kita 3, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Loft A, Asagaya", address: "Asagaya kita 1, Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  { livehouse: "Yellow Vision, Asagaya", address: "Asagaya kita 2, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Next Sunday, Asagaya", address: "Asagaya Shinmeiguu, Nakasugi dori Ave., Asagaya kita 1, Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  # Akihabara
  { livehouse: "秋葉原 CLUB GOODMAN, Akihabara", address: "Kanda-Sakumagashi, Chiyoda, Tokyo, Japan" },
  { livehouse: "Akihabara Marz, Akihabara", address: "Kanda-Sakumacho 1-chome, Kanda-Sakumacho, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "Fukumori, Akihabara", address: "Kanda-Sudacho 1-chome, Kanda-Sudacho, Chiyoda, Tokyo, 101-0041, Japan" },
  { livehouse: "Akihabara ZEST, Akihabara", address: "Soto-Kanda 2, 外神田, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "TOKYOITE! the music space", address: "Soto-Kanda 2, 外神田, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "NARU Jazz Livehouse, Kanda", address: "Kanda-Surugadai 2-chome, Kanda-Surugadai, Chiyoda, Tokyo, 101-0062, Japan" },
  { livehouse: "BECK アキバ ライブハウス リハーサルスタジオ セッションバー, Kanda", address: "Kanda-Sakumacho 2-chome, Kanda-Sakumacho, Chiyoda, Tokyo, 101-0025, Japan" },
  # Roppongi
  { livehouse: "SUPER DELUXE, Roppongi", address: "Nishiazabu-yonchome, Kogai-zaka Street, Roppongi 6-chome, Nishi-Azabu 4-chome, Azabu, Minato, Tokyo, 106-0031, Japan" },
  { livehouse: "BILLBOARD LIVE TOKYO, Roppongi", address: "Akasaka 9-chome, Akasaka, Azabu, Minato, Tokyo, 106-0032, Japan" },
  { livehouse: "六本木 CLUB EDGE, Roppongi", address: "Roppongi 5-chome, Roppongi, Azabu, Minato, Tokyo, 106-8537, Japan" },
  { livehouse: "EX THEATER ROPPONGI", address: "DUO SCALA NISHIAZABU TOWER, Roppongi-dori, Roppongi 6-chome, Nishi-Azabu 1-chome, Azabu, Minato, Tokyo, 106-0031, Japan" },
  { livehouse: "BAUHAUS, Roppongi", address: "アロービル, 7, Roppongi, Azabu, Minato, Tokyo, 106-0032, Japan" },
  { livehouse: "Jazz House ALFIE, Roppongi", address: "Roppongi 6-chome, Roppongi, Azabu, Minato, Tokyo, 106-8001, Japan" },
  { livehouse: "Common, Roppongi", address: "六本木Dスクエア, 5, Roppongi, Azabu, Minato, Tokyo, 106-0032, Japan" },
  # Ikebukuro
  { livehouse: "Live garage Adm, Ikebukuro", address: "Higashi-Ikebukuro 1-chome, Toshima, Tokyo, 170-0013, Japan" },
  { livehouse: "池袋 Live inn ROSA, Ikebukuro", address: "Nishi-Ikebukuro 1-chome, Toshima, Tokyo, 171-8504, Japan" },
  { livehouse: "Absolute Blue, Ikebukuro", address: "Nishi-Ikebukuro 1-chome, Toshima, Tokyo, 171-8504, Japan" },
  { livehouse: "Apple Jump, Ikebukuro", address: "Nishi-Ikebukuro 3-chome, Toshima, Tokyo, 171-0021, Japan" },
  { livehouse: "KAKULULU, Ikebukuro", address: "Higashi-Ikebukuro 4-chome, Toshima, Tokyo, 170-6002, Japan" },
  { livehouse: "INDEPENDENCE, Ikebukuro", address: "Nishi-Ikebukuro 3-chome, Toshima, Tokyo, 171-0021, Japan" },
  { livehouse: "池袋 LiveHouse mono, Ikebukuro", address: "South Ikebukuro, Toshima, Tokyo, Japan" },
  # Saitama
  { livehouse: "Saitama Super Arena", address: "Saitama Super Arena, Shintoshin, Chuo Ward, Saitama, Saitama Prefecture, 330-0081, Japan" },
  { livehouse: "HEAVEN'S ROCK さいたま新都心, Saitama", address: "Kamiochiai 4-chome, Chuo Ward, Saitama, Saitama Prefecture, 338-0001, Japan" },
  { livehouse: "live 空舞台, Saitama", address: "Higashi-Iwatsuki 4-chome, Iwatsuki Ward, Saitama, Saitama Prefecture, 339-0065, Japan" },
  { livehouse: "Narciss, Saitama", address: "Takasago 2-chome, Urawa Ward, Saitama, Saitama Prefecture, 330-0063, Japan" },
  { livehouse: "MUSIC & LIVE BAR CITYLIGHTS, Saitama", address: "Kamiochiai, Chuo Ward, Saitama, Saitama Prefecture, 330-0081, Japan" },
  { livehouse: "西川口 Live House Hearts, Saitama", address: "Namiki 2-chome, Iwatsuki Ward, Saitama, Saitama Prefecture, 337-0002, Japan" },
  { livehouse: "ayers, Saitama", address: "Tokiwa 9-chome, Urawa Ward, Saitama, Saitama Prefecture, 336-0074, Japan" },
  # Kichijoji
  { livehouse: "NEPO, Mitaka", address: "Shimorenjaku 1-chome, Mitaka, Tokyo, 181-0013, Japan" },
  { livehouse: "吉祥寺 SHUFFLE, Kichijoji", address: "Kichijoji Minamicho, Musashino, Tokyo, 180-0003, Japan" },
  { livehouse: "Silver Elephant, Kichijoji", address: "吉祥寺駅, Heiwa Dori, Kichijoji Honcho, Musashino, Tokyo, 180-8520, Japan" },
  { livehouse: "Black and Blue, Kichijoji", address: "Kichijoji-honcho 1-chome, Musashino, Tokyo, 180-0004, Japan" },
  { livehouse: "Daydream Kichijoji", address: "Kichijoji, Heiwa Dori, Kichijoji-honcho 1-chome, Musashino, Tokyo, 180-8552, Japan" },
  { livehouse: "Strings, Kichijoji", address: "Kichijoji Honcho, Musashino, Tokyo, 180-8520, Japan" },
  # Koenji
  { livehouse: "AG22, Koenji", address: "AG22, 高南通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "AMP cafe, Koenji", address: "AMP, Koenji Look Street, Koenji minami 2, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan " },
  { livehouse: "DJ's Bar Cave, Koenji", address: "DJ's bar Koenji Cave, 高南通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Faith, Koenji", address: "FAITH, Kannana-dori Avenue, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Higashi Koenji U.F.O.CLUB (UFO Club), Koenji", address: "Koenji Higashi 2-chome, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Knock (Koenji)", address: "Knock, 6, Koenji minami 3, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Koenji High", address: "Koenji High, 南中央通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Oriental Force, Koenji", address: "Oriental Force, 第８日東ビル, Koenji minami 3, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Penguin House, Koenji", address: "PENGUIN HOUSE, 純情商店街, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Roots (Koenji)", address: "ROOTS!, Central Road, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Higashi Koenji U.F.O.CLUB (UFO Club)", address: "Koenji Higashi 2-chome, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "SUBstore Koenji", address: "SUBstore Tokyo, 高円寺中通り, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  # Yokohama
  { livehouse: "1000 Club, Yokohama", address: "1000 CLUB, Minamisaiwai 2-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0005, Japan" },
  { livehouse: "El Puente, Yokohama", address: "Minamisengencho, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0024, Japan" },
  { livehouse: "KT Zepp Yokohama", address: "KT Zepp Yokohama, 6, Minatomirai 4-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0012, Japan " },
  { livehouse: "Pacifico Yokohama", address: "PACIFICO Yokohama North, 2, Minatomirai 1-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0012, Japan" },
  { livehouse: " Pia Arena MM, Yokohama", address: "PIA ARENA MM, 1, Nishi Ward, Yokohama, Kanagawa Prefecture, 231-0017, Japan" },
  { livehouse: "Impact Hub HQ", address: "Meguro, Tokyo, Japan" },
]

# bands = [
#   { band: "Red Velvet", description: 'A powerhouse K-pop girl group known for their unique dual concept of "Red" (bright, bubbly pop) and "Velvet" (smooth R&B). Hits like "Red Flavor" and "Psycho" have solidified their global popularity.', genre: "K-pop" },
#   { band: "Arctic Monkeys", description: 'British indie rock band hailing from Sheffield, known for their electrifying live performances and critically acclaimed albums like "AM" and "Whatever People Say I Am, Thats What Im Not".', genre: "Indie Rock" },
#   { band: "Charles Bradley", description: 'Late-blooming soul sensation who rose to fame in his 60s with heart-wrenching performances and songs like "Changes". His gritty voice channels the raw emotion of classic soul.', genre: "Soul" },
#   { band: "Vulfpeck", description: 'Funk band known for their tight grooves, minimalist approach, and playful live shows. Their song "Back Pocket" became a viral sensation, and they often experiment with live recording techniques.', genre: "Funk" },
#   { band: "The Kooks", description: 'Indie rockers from Brighton, England, blending catchy guitar riffs and Britpop influences. Their debut album "Inside In/Inside Out" was a defining sound of the mid-2000s indie scene.', genre: "Indie Rock" },
#   { band: "Trombone Shorty & Orleans Avenue", description: "A high-energy band from New Orleans, led by jazz and funk virtuoso Trombone Shorty. They blend jazz, funk, and hip-hop influences, bringing the sounds of New Orleans to the world stage.", genre: "Funk Soul" },
#   { band: "BTS", description: 'Global K-pop phenomenon known for their tight choreography, deep lyricism, and social impact. BTS has topped charts worldwide with songs like "Dynamite" and "Butter", breaking countless records.', genre: "K-pop" },
#   { band: "Supergrass", description: 'British alternative rock band famous for their catchy melodies and energetic sound. Their hit "Alright" became an anthem of the 90s Britpop era.', genre: "Alternative Rock" },
#   { band: "Coldplay", description: 'British pop rock giants known for anthemic hits like "Yellow" and "Fix You". Their evolving sound has spanned from melancholic rock to electronic-infused pop.', genre: "Pop Rock" },
#   { band: "Free Nationals", description: 'Anderson .Paaks backing band, combining soul, funk, and R&B to create a smooth, groovy sound. Known for their work on .Paaks albums and their solo work, including the hit "Beauty & Essex".', genre: "Soul" },
#   { band: "NewJeans", description: 'Rising K-pop girl group known for their fresh, retro-inspired sound. Their debut tracks "Attention" and "Hype Boy" quickly catapulted them into stardom.', genre: "K-pop" },
#   { band: "Franz Ferdinand", description: 'Scottish indie rock band known for their angular guitar riffs and dance-punk energy. Their breakout hit "Take Me Out" became a defining track of the 2000s indie scene.', genre: "Indie Rock" },
#   { band: "Blur", description: 'Pioneers of the Britpop movement, Blur blended clever, observational lyrics with catchy melodies. Their hits like "Song 2" and "Parklife" defined the sound of 90s British music.', genre: "Britpop" },
#   { band: "The Beatles", description: 'Arguably the most influential rock band of all time, The Beatles revolutionized music with their innovative songwriting and groundbreaking albums like "Sgt. Peppers" and "Abbey Road".', genre: "Rock" },
#   { band: "Pulp", description: 'Icons of the Britpop era, Pulp brought wit, irony, and social commentary to their songs. Their anthem "Common People" remains a timeless classic of 90s UK music.', genre: "Britpop" },
#   { band: "The Stone Roses", description: "Manchesters alternative rock legends who blended indie rock with dance rhythms. Their self-titled debut album is considered one of the greatest British albums of all time.", genre: "Alternative Rock" },
#   { band: "Durand Jones & The Indications", description: "A soulful group that channels the vintage sounds of 60s and 70s soul, with a modern twist. Their heartfelt lyrics and retro grooves have won them a dedicated following.", genre: "Soul" },
#   { band: "EXO", description: 'One of K-pops biggest boy bands, EXO is known for their harmonious vocals, synchronized choreography, and hits like "Growl" and "Love Shot" that have captivated fans worldwide.', genre: "K-pop" },
#   { band: "Cory Henry & The Funk Apostles", description: "Led by virtuoso keyboardist Cory Henry, this band blends funk, soul, and gospel, delivering electrifying performances filled with tight grooves and powerful vocals.", genre: "Funk Soul" },
#   { band: "Thundercat", description: "Grammy-winning bassist and singer who fuses jazz, funk, and electronic music. His virtuosic bass playing and quirky persona have earned him a cult following in modern music.", genre: "Funk" },
#   { band: "Kasabian", description: 'Indie rock giants from Leicester, known for their anthemic sound and energetic live shows. Hits like "Fire" and "Club Foot" have become festival favorites.', genre: "Indie Rock" },
#   { band: "Muse", description: 'British alternative rock band known for their epic, operatic sound and futuristic themes. Albums like "Absolution" and "The Resistance" pushed the boundaries of modern rock.', genre: "Alternative Rock" },
#   { band: "Emily King", description: 'Soulful singer-songwriter blending R&B, pop, and jazz influences. Her smooth vocals and introspective songwriting shine on albums like "Scenery" and "The Switch".', genre: "Soul" },
#   { band: "Sharon Jones & The Dap-Kings", description: "Soul revivalists who captured the raw, gritty energy of 60s and 70s funk and soul. Sharon Jones powerhouse voice drove the bands sound, making them a staple of the genre.", genre: "Soul" },
#   { band: "Bloc Party", description: 'British indie rock band known for their angular guitar riffs, driving rhythms, and politically charged lyrics. Their debut album "Silent Alarm" is considered a modern classic.', genre: "Indie Rock" },
#   { band: "Lake Street Dive", description: 'Genre-bending band combining soul, pop, and jazz. Lead singer Rachael Prices powerful vocals are the highlight of their eclectic sound, showcased in hits like "Good Kisser".', genre: "Soul Pop" },
#   { band: "Tank and The Bangas", description: 'New Orleans-based band blending funk, soul, hip-hop, and spoken word. Frontwoman Tarriona "Tank" Balls theatrical energy has earned the band critical acclaim and a loyal fanbase.', genre: "Funk Soul" },
#   { band: "Anderson .Paak", description: 'Multi-talented rapper, singer, and drummer who blends R&B, hip-hop, and funk. His raspy vocals and infectious grooves on tracks like "Come Down" have made him a genre-defying star.', genre: "R&B" },
#   { band: "The Libertines", description: "UK indie rockers known for their raw energy and chaotic live performances. Led by Pete Doherty and Carl Barât, their influence on the British indie scene is undeniable.", genre: "Indie Rock" },
#   { band: "Oasis", description: 'Britpop legends whose anthems "Wonderwall" and "Dont Look Back in Anger" defined a generation. Oasis swaggering sound and larger-than-life attitude made them global rock icons.', genre: "Britpop" },
#   { band: "Jungle", description: 'London-based modern soul collective known for their smooth, groove-heavy sound and atmospheric music videos. Tracks like "Busy Earnin" capture their unique blend of funk, soul, and electronic.', genre: "Modern Soul" },
#   { band: "NCT 127", description: 'K-pop boy band with a diverse, experimental sound that blends hip-hop, pop, and R&B. Known for their energetic performances and hits like "Cherry Bomb" and "Kick It".', genre: "K-pop" },
#   { band: "Hiatus Kaiyote", description: "Australian future soul band blending jazz, soul, and electronic music. Their unconventional sound and intricate compositions have earned them a global cult following.", genre: "Future Soul" },
#   { band: "Radiohead", description: 'Pioneers of experimental rock, known for pushing boundaries with their innovative sound. Albums like "OK Computer" and "Kid A" redefined alternative rock for a new generation.', genre: "Alternative Rock" },
#   { band: "Elbow", description: 'British alternative rock band known for their orchestral sound and poetic lyrics. Tracks like "One Day Like This" and "Grounds for Divorce" showcase their anthemic, yet intimate style.', genre: "Alternative Rock" },
#   { band: "TWICE", description: 'K-pop girl group known for their catchy hooks, vibrant visuals, and energetic performances. Hits like "TT" and "Fancy" have made them one of the most popular acts in K-pop.', genre: "K-pop" },
#   { band: "Lianne La Havas", description: 'British singer-songwriter blending soul, folk, and jazz influences. Her emotive voice and introspective lyrics shine in albums like "Blood" and her self-titled "Lianne La Havas".', genre: "Soul" },
#   { band: "MAMAMOO", description: 'Charismatic K-pop girl group known for their powerful vocals and bold performances. Their genre-blending sound spans pop, R&B, and jazz, with hits like "HIP" and "Starry Night".', genre: "K-pop" },
#   { band: "The 1975", description: "British pop rock band with a penchant for blending 80s pop, indie rock, and electronica. Fronted by the enigmatic Matty Healy, theyve gained a cult following for their eclectic sound.", genre: "Pop Rock" },
#   { band: "Black Pumas", description: 'Austin-based psychedelic soul duo known for their soulful, vintage-inspired sound. Their hit "Colors" has earned them widespread acclaim and Grammy nominations.', genre: "Psychedelic Soul" },
#   { band: "DAngelo and The Vanguard", description: 'Neo-soul pioneers who redefined the genre with their sultry grooves and socially conscious lyrics. Their album "Black Messiah" is a modern classic in soul and R&B.', genre: "Neo-Soul" },
#   { band: "ITZY", description: 'K-pop girl group with a rebellious, empowering message and bold choreography. Known for hits like "Dalla Dalla" and "Wannabe", they are quickly rising in the global K-pop scene.', genre: "K-pop" },
#   { band: "Keane", description: 'British alternative rock band known for their piano-driven sound and melancholic lyrics. Their debut album "Hopes and Fears" includes hits like "Somewhere Only We Know".', genre: "Alternative Rock" },
#   { band: "The Internet", description: 'Soul and funk collective blending R&B, jazz, and hip-hop. Fronted by Syd, their smooth, laid-back grooves can be heard on tracks like "Girl" and "Come Over".', genre: "Soul" },
#   { band: "The Verve", description: 'British alternative rock band known for their sweeping soundscapes and hit single "Bitter Sweet Symphony", which became one of the most iconic tracks of the 90s.', genre: "Alternative Rock" },
#   { band: "Stray Kids", description: 'Self-producing K-pop boy band known for their hard-hitting, experimental sound. Songs like "Gods Menu" showcase their powerful energy and genre-bending style.', genre: "K-pop" },
#   { band: "Supergrass", description: 'British alternative rock band famed for their energetic live shows and catchy tunes. Their hit "Alright" became synonymous with the youthful exuberance of the Britpop era.', genre: "Alternative Rock" },
#   { band: "PinkPantheress", description: 'Bedroom pop artist blending nostalgic 2000s sounds with a modern twist. Her viral hits like "Pain" and "Just for Me" have resonated with a new generation of pop fans.', genre: "Pop" },
#   { band: "His & Her Circumstances", description: "Emotional rock band whose music embraces vulnerability and catharsis, delivering heartfelt, introspective lyrics with raw, emo-infused energy.", genre: "Emo Rock" },
# ]

bands = [
  {
    band: "nowheres",
    description: "Hailing from the USA, nowheres is located in Tokyo. When they are not spreading doom and gloom at live houses, they are making and self-producing songs. Come on down and get sad as fuck as you yell and scream lyrics such as 'Cigarette!' and 'Die!'. If you like bands like The Cure and New Order, you definitely won’t want to miss them!",
    genre: ["post punk", "boat punk"],
  },
  {
    band: "Vaiwatt",
    description: "Japanese rebels melting punk-pop and grunge into a Blade Runner technicolour fantasy –Kandy Pop for Jet Boys and Jet Girls, Love Missiles that Smell Like Teen Spirit!",
    genre: ["grunge", "punk", "j-punk"],
  },
  {
    band: "Fever Moon",
    description: "FVRMN, formerly known as Fever Moon, is a Tokyo-based band that blends nostalgic punk influences with a gritty, anthemic sound. Their music channels the essence of bands like Hüsker Dü and The Replacements, featuring emotionally charged vocals and a mix of downtrodden yet hopeful tones. Their latest album, 'Back To The Whip,' showcases this dynamic, with standout tracks like 'Diamonds' and 'Back To The Whip' capturing their signature blend of smoky vocals and catchy melodies.",
    genre: ["alternative rock", "indie rock"],
  },
  {
    band: "Thee Blackdoor Blues",
    description: "A two-piece acid-garage/Future-blues/Art-punk/Experimental-noise/Avant-garde band from Mexico and Japan.",
    genre: ["alternative rock", "indie rock", "garage rock", "acid garage", "experimental noise"],
  },
  {
    band: "AZTEC BRIDES",
    description: "Brought together by destiny - three long-haired brunettes and a blond got together to play some rock n' roll!",
    genre: ["alternative rock", "indie rock", "funk rock"],
  },
  {
    band: "Luby Sparks",
    description: "Luby Sparks crafts a captivating blend of alternative rock, shoegaze, and indie influences that sets them apart in the modern music scene. Their sound is a mesmerizing mix of dreamy, atmospheric textures and driving rhythms, offering a rich sonic experience that oscillates between reflective introspection and dynamic energy.",
    genre: ["alternative rock", "indie rock", "shoegaze", "indie", "japanese dream pop", "japanese shoegaze"],
  },
  {
    band: "futures",
    description: "'City Hip Music' is a project led by Ryō Kusuno (Vocals) and Mei Suzuki (Bass). They are involved in track-making, collaborating with support musicians for song production, and engaging in live activities.",
    genre: ["city pop", "indie"],
  },
  {
    band: "Otherside",
    description: "Otherside is a five-piece Japanese band influenced by shoegaze, grunge, and alternative rock.",
    genre: ["alternative rock", "indie rock", "shoegaze", "indie"],
  },
  # {
  #   band: "Kikagaku Moyo",
  #   description: "Kikagaku Moyo call their sound psychedelic because it encompasses a broad spectrum of influence. Their music incorporates elements of classical Indian music, Krautrock, Traditional Folk, and 70s Rock.",
  #   genre: ["psychedelic", "krautrock", "instrumental stoner rock", "japanese psychedelic", "japanese psychedelic rock", "neo-psychedelic"],
  # },
  {
    band: "Minami Deutsch",
    description: "Minami Deutsch is a Krautrock band from Tokyo. Formed by Kyotaro Miula in 2014, they got their start playing live music on the busy streets of Tokyo.",
    genre: ["alternative rock", "indie rock", "krautrock", "japanese psychedelic rock", "neo-kraut", "neo-psychedelic"],
  },
  {
    band: "メルティースマイル",
    description: "SEKAI (Vocals/Guitar), Ide-chan (Drums/Chorus), Kyōzan Waku (Bass/Chorus), and SNAKY (Second Guitar) form a theatrical hard romance band that feels like diving headfirst into a toy box. 🌈🎸🥁",
    genre: ["glam", "glam metal", "alternative rock", "indie rock"],
  },
  {
    band: "Meisou",
    description: "We are Meisou, a revitalized grunge punk band. We're performing street lives to turn Japanese music 180°. We want to create a new wave in Japan. We’re a dynamic three-piece rock band 👍 and share various videos 🤘🔥🔥🔥 We love grunge!!",
    genre: ["garage rock", "grunge"],
  },
  {
    band: "Catchy Claws",
    description: "Energetic and melodic Rock music band, original material guaranteed to make your foot tap and head bang.",
    genre: ["rock"],
  },
  {
    band: "ASK I FALL",
    description: "ASK I FALL is an international Metalcore band based in Tokyo, Japan. Formed in 2020, the band was united by their shared passion for Japanese culture and Metal music.",
    genre: ["metalcore", "emo"],
  },
  {
    band: "Wild Charge",
    description: "Fast, Raw, Beer chugging, Guitar shredding, Heavy Metal Maniacs from California! Keep it true and crank the tunes!",
    genre: ["metal", "rock", "speed metal"],
  },
  {
    band: "otoshik",
    description: "Timeless and Contemporary. re-writing the rules of 'chill.",
    genre: ["pop", "indie pop"],
  },
  {
    band: "The Devils&Libido",
    description: "INSTRUMENTAL PROGRESSIVE PUNK(NEON PUNK) from Tokyo, Japan. Bass TAIRA, Guitar AYANA, Drums DAIGORO",
    genre: ["alternative rock", "progressive rock", "post rock"],
  },
  {
    band: "Sho Sugita",
    description: "Sho Sugita is an electronic artist known for his innovative and genre-blending sound. His music combines intricate synth work with ambient textures, creating a rich and immersive auditory experience.",
    genre: ["ambient"],
  },
  {
    band: "Ichiko Aoba",
    description: "Ichiko Aoba is a Japanese singer-songwriter and composer known for her ethereal and introspective sound. Her music combines delicate acoustic guitar work with hauntingly beautiful vocals, creating a serene and immersive atmosphere. Aoba's style blends elements of folk, ambient, and traditional Japanese music, resulting in a unique and evocative sonic experience.",
    genre: ["j-acoustic", "acoustic"],
  },
  { band: "MASS OF THE FERMENTING DREGS", description: "MASS OF THE FERMENTING DREGS is a Japanese band known for their fusion of shoegaze, alternative rock, and post-rock. Their sound is characterized by dense, atmospheric layers of guitar effects, powerful drumming, and emotive vocals. The band's music often features a mix of dreamy, introspective passages and intense, energetic bursts, creating a dynamic and immersive listening experience.", genre: ["japanese emo", "japanese post-rock", "japanese shoegaze"] },
  { band: "Botolph Dissidents", description: "Formed in 2007, Botolph Dissidents is the project of vocalist, guitarist and band leader Andrew McGuire. Based out of Tokyo, Japan, this three-piece international metal band is comprised of working musicians, that run jam sessions and support local indie bands in the Tokyo area.", genre: ["metal"] },
  { band: "Creep Down", description: "Creep Down was formed in 2017 in memory of the singer's Mother's passing in 2016. Elaine Gross worked for Rolling Stone magazine in the 1970s interviewing Alice Cooper & Edgar Winter. Creep Down has performed since 2017 in the Tokyo Music underground scene in Shibuya.", genre: ["alternative rock"] },
  { band: "Marina Yozora", description: "With a whisper/husky voice blending with dreamy electric guitar sounds, Marina Yozora captivates 3-4 minutes of your time to a vast place. She is a dream pop, indie pop, shoegazey singer-songwriter, born in Japan, but also spent her childhood in Houston Texas and Ho Chi Minh.", genre: ["j-ambient"] },
  { band: "Eryyy", description: "Eryyy is a Japanese artist known for their distinctive blend of electronic, pop, and experimental music. Their sound is characterized by innovative production techniques, eclectic influences, and a focus on creating immersive, genre-blending tracks.", genre: ["electronic", "pop"] },
  { band: "Laidback CX", description: "MC CHOCOLATE CAKE × Isam The MXsterpiece Cake from Sandiego, MXsterpiece from Kanagawa", genre: ["j-rap"] },
  { band: "Tropical Death", description: "Formed in 2014, this four-piece rock band is based along the Chuo Line in Tokyo. They play a unique blend of post-hardcore, surf rock, and disco punkpost-hardcore, surf rock, and disco punk.", genre: ["disco punk", "post-hardcore"] },
  { band: "Konnichiwa Typhoon", description: "Drawing inspiration from a diverse array of musical influences, Konnichiwa Typhoon's sound is a captivating blend of indie, slacker rock, and funk.", genre: ["indie rock", "slacker rock", "funk"] },
  { band: "Nao Right Now", description: "Born in Tokyo on Jan 18, 1989. Listening to hard rock and progressive rock since childhood. Met mixture-band such as \"Rage Against The Machine\" while staying in the United States in high school period, reached to various genres of music such as hip-hop, funk, soul, house, and electro, and got to know the Talkbox.", genre: ["electro", "funk", "soul", "house"] },
  { band: "THE BLACK DOLPHINS", description: "We are a garage rock band in japan!", genre: ["garage rock"] },
  { band: "Hundora", description: "HUNDORA is the musical manifestation of the psychosonic serendipities of lead singer and guitarist MIKE, bassist TK, and drummer OLAF. The music reflects and fuses Mike’s idiosyncratic songwriting and eclectic guitar playing, TK’s Southern California punk rock roots, and Olaf’s European and American hard rock and heavy metal heritage.", genre: ["punk rock", "hard rock", "heavy metal"] },
  { band: "Santa Dharma", description: "Santa Dharma is a Tokyo-based experimental pop duo formed in 2012 after a chance meeting in a tiny hookah bar. Their nostalgia-infused DIY sound mixes 80s toy synthesizers, fuzzy electric ukulele, retro drum machines, and field recordings as a backdrop for lyrics about reincarnation and space travelers.", genre: ["pop", "bedroom pop", "experimental pop"] },
  { band: "Yeti Valhalla", description: "Yeti Valhalla has been actively performing around the world since 2014. Originating from Vancouver, BC Canada, Yeti has found success most recently in Japan and the USA.", genre: ["rock"] },
  { band: "HANJŌ", description: nil, genre: ["electronic"] },
  { band: "JiliJili Moksha", description: nil, genre: ["garage rock", "psychedelic rock"] },
  { band: "CHO CO PA CO CHO CO QUIN QUIN", description: "CHO CO PA CO CHO CO QUIN QUIN is a Japanese band known for their eclectic and genre-blending style. Their music combines elements of rock, pop, and experimental sounds, creating a dynamic and unpredictable listening experience.", genre: ["rock", "pop", "alternative rock"] },
  { band: "Half Mile Beach Club", description: "Half Mile Beach Club has been portraying seaside scenes with their unique Balearic sound which is blending Latin jazz, club music and indie rock. After organizing and casually performing at the music and film event Half Mile Beach Club at their local beach area, the four musicians formed a band under the same name Half Mile Beach Club.", genre: ["alternative rock", "indie rock"] },
  { band: "Cornelius", description: "Cornelius is the solo project of Keigo Oyamada. He began his career as Cornelius in 1993 and has since released seven original albums. In addition to his solo work, he is actively involved in collaborations, remixes, installations, and production with numerous artists both domestically and internationally.", genre: ["indietronica", "j-ambient", "japanese alternative pop", "shibuya-kei"] },
  { band: "Lamp", description: "Lamp was formed in 2000 by Nagai Yusuke (vocals), Sakakibara Kaori (vocals), and Someya Taiyo (guitar). They have released a total of nine albums to date, beginning with 2003's 'Soyokaze Apartment 201' leading up to their latest, 2023's 'Dusk to Dawn'.", genre: ["japanese alternative pop"] },
  { band: "Mei Semones", description: "Jazz influenced indie artist based in Brooklyn, NY.", genre: ["brooklyn indie", "indie"] },
  { band: "KIRINJI", description: "In 1996, brothers Takagi and Yasuaki Horikomi formed the band Kirinji. They made their major debut in 1998. In 2013, Yasuaki Horikomi left the band, and that same year, Kirinji reformed as a six-member band under the name KIRINJI.", genre: ["city pop", "j-rock"] },
  { band: "HYUKOH", description: "HYUKOH is a Korean indie rock band comprised of singer-songwriter OHHYUK, guitarist HYUNJAE, drummer INWOO, and bassist DONGGEON. They have released five albums to date, from the debut EP [20] in 2014, to [22], [23], [24:How to find true love and happiness], and as of January 2020, [through love], the band’s latest album.", genre: ["korean indie folk", "korean r&b"] },
  { band: "CHAI", description: "We are CHAI. When you think of all things Pink, a sound that fuses the likings of Basement Jaxx, Gorillaz, CSS and Tom Tom Club, with lyrics focused on “women empowerment” and redefining the definition of “kawaii” or cute in Japanese, you think of CHAI.", genre: ["japanese alternative rock"] },
  { band: "OGRE YOU ASSHOLE", description: "OGRE YOU ASSHOLE is a 4 piece band from Japan. OYA has established their reputation as a live band by performing completely different live arrangements from their original recording versions on their albums at their shows.", genre: ["j-rock", "japanese post-punk", "japanese post-rock"] },
  { band: "mitsume", description: "Moto Kawabe(Gt&VO), Mao Otake(Gt), Yojiro Suda(Dr) and nakayaan(Ba) started mitsume in Tokyo in 2009. The band has released five albums and six singles on their own label.", genre: ["japanese alternative rock", "japanese indie pop"] },
  { band: "His & Her Circumstances", description: "Singing about heartbreak, video games and everything in between, His and Her Circumstances (named after an obscure 90s anime) wear their hearts on their sleeves as they blast out endearing emo choruses. Drenched in pop culture influences, they bring the noise, but more importantly, bring the feels.", genre: ["alternative rock", "emo", "indie rock"] },
  {
    band: "宇宙ネコ子",
    description: "宇宙ネコ子 (Uchū Nekoko) is a Japanese artist renowned for their eclectic blend of electronic, pop, and experimental music. Known for their imaginative soundscapes and playful aesthetics, Uchū Nekoko's work often features vibrant, otherworldly elements combined with catchy melodies and innovative production techniques.",
    genre: ["japanese dream pop", "japanese shoegaze"],
  },
  {
    band: "Kani Crabb",
    description: "Kani Crabb is a musician known for their vibrant and eclectic approach to music. Their sound blends elements of rock, pop, and electronic, creating a unique and energetic style.",
    genre: ["alternative rock", "pop rock"],
  },
  {
    band: "HARU NEMURI",
    description: "HARU NEMURI is a Japanese artist celebrated for her genre-defying music that blends elements of alternative, hip-hop, and electronic. Her sound is characterized by its experimental approach, combining dynamic beats, introspective lyrics, and a fusion of various musical styles.",
    genre: ["japanese alternative pop"],
  },
  {
    band: "Maverick City Music",
    description: "Maverick City started with a dream to make space for folk that would otherwise live in their own separate worlds. To break the unspoken rules that exist in the CCM and Gospel World!",
    genre: ["sda a cappella", "worship"],
  },
  {
    band: "Cardi B",
    description: "Rapper and entertainer Cardi B draws from a seemingly never-ending supply of confidence, charisma, and evisceratingly sharp flows.",
    genre: ["pop", "rap"],
  },
  {
    band: "NewJeans",
    description: "Rising K-pop girl group known for their fresh, retro-inspired sound. Their debut tracks 'Attention' and 'Hype Boy' quickly catapulted them into stardom.",
    genre: ["k-pop", "k-pop girl group"],
  },
  {
    band: "DE DE MOUSE",
    description: "From Acid House to Amen Break, and Hip Hop to Fusion, DE DE MOUSE links and mixes keywords together to create new sounds for the Electric scene. A mix of sounds of synthesizer intertwined with unique chords, he creates an energetic beat that fits in the any genre.",
    genre: ["japanese electropop", "electronic"],
  },
  {
    band: "CAPSULE",
    description: "Capsule is an electro-pop duo that began their activities in 1997. They were among the first to adopt a virtual studio approach to music production, a pioneering move that had a significant impact on the music scene with their free-spirited and stimulating tracks.",
    genre: ["japanese dance pop", "japanese electropop", "picopop"],
  },
  {
    band: "Nekosen",
    description: "猫戦（ネコセン）。ネコセンキャットファイト . We are a Japanese pop cat club. www.instagram.com/odoroyocat",
    genre: ["indie pop"],
  },
  {
    band: "Perfume",
    description: "Japanese pop idol trio Perfume debuted in the late 2000s with their double-platinum breakthrough, Game, the first showcase for their high-BPM techno-dance anthems. From there, they remained at the top of the Japanese pop charts, delivering reliably energetic excursions fit for intergalactic dancefloors.",
    genre: ["bitpop", "j-idol", "j-pop", "j-pop girl group", "japanese electropop", "picopop", "electronic"],
  },
  {
    band: "fox capture plan",
    description: "FOX CAPTURE PLAN is a Japanese jazz rock band formed in 2011. They have played shows on various huge festivals in the world, and have been composing songs for TV dramas, Movies, Anime, and Video games.",
    genre: ["japanese jazz fusion", "japanese jazztronica", "japanese math rock", "japanese post-rock", "math rock", "post rock"],
  },
  {
    band: "Heaven In Her Arms",
    description: "Heaven in Her Arms are a Japanese post-hardcore band from Tokyo. Named after a song from Converge's 2001 album Jane Doe, they have released 3 studio albums, 2 EPs and 6 splits since 2005.",
    genre: ["blackened screamo", "japanese black metal", "japanese emo", "japanese post-hardcore", "japanese screamo", "skramz"],
  },
  {
    band: "Glass Beams",
    description: "Glass Beams is an Australian musical trio from Melbourne, Australia. The band blends synth, rock, psychedelic, electric guitar, eastern instrumentals, and subtle cooing vocals.",
    genre: ["neo-psychedelic"],
  },
  {
    band: "Meaningful Stone",
    description: "True to her stage name, which means ‘even a stone has meaning,’ Meaningful Stone is a singer-songwriter who seeks the meaning of life through her music.",
    genre: ["k-indie", "korean indie folk", "indie"],
  },
  {
    band: "SE SO NEON",
    description: "SE SO NEON is a Korean band (Hwang Soyoon (vox/gtr), Park Hyunjin (b)) debuted in 2017. They have explored their own brand of lo-fi and vintage sound, with a wide spectrum of musical influences varying from blues, psychedelic rock to new wave and synth pop.",
    genre: ["k-indie", "korean indie rock", "korean city pop", "indie"],
  },
  {
    band: "mei ehara",
    description: "mei ehara is a singer songwriter, born in 1991 and based in Tokyo, Japan. While in school, she started independent filmmaking and eventually turned her hand to home recording. Following several self released recordings, she released her first full-length album 'Sway' (2017) and the second album 'Ampersands' (2020), both on renowned indie label KAKUBARHYTHM.",
    genre: ["j-indie"],
  },
  {
    band: "Charli xcx",
    description: "it's charli baby ;)",
    genre: ["art pop", "candy pop", "metropopolis", "pop", "uk pop"],
  },
  {
    band: "Big Thief",
    description: "Big Thief is an American indie folk band formed in Brooklyn, New York, in 2015. The band consists of Adrianne Lenker (vocals, guitar), Buck Meek (guitar, backing vocals) and James Krivchenia (drums). Between 2015 and 2024, the band also included longtime bass guitarist, Max Oleartchik.",
    genre: ["art pop", "brooklyn indie", "chamber pop", "countrygaze", "indie pop", "indie rock", "small room"],
  },
  {
    band: "24HOURS",
    description: "24Hours is an independent South Korean alternative rock band formed 2011 in Seoul. The group consists of four members: Seungjin, Hyemi, Hyukjae and Eunhong. They debuted on March 3, 2012 with the single album Blackhole.",
    genre: ["alternative rock", "indie rock", "k-indie"],
  },
  {
    band: "死んだ僕の彼女",
    description: "shinda boku no kanojo (my dead girlfriend) are one of japanese NOISE POP bands. Currently, the band consists of Ishikawa (vocal & guitar) , Ideta (vocal & synthesizer), Kinoshita (guitar), Kawakami (bass) and Kunii (drums).",
    genre: ["glitchbreak", "japanese shoegaze"],
  },
  {
    band: "Hitsujibungaku",
    description: "The band consists of Moeka Shiotsuka (vocals/guitar), Yurika Kawanishi (bass), and Hiroa Fukuda (drums). They are known for their delicate yet powerful alternative rock sound.",
    genre: ["j-rock", "japanese alternative rock"],
  },
  {
    band: "Phoebe Bridgers",
    description: "A Los Angeles-based singer/songwriter with a dreamy and hook-filled indie pop heart, Phoebe Bridgers' witty lyrical perspectives, sadly beautiful songs, and commanding melodies have connected with millions of fans worldwide.",
    genre: ["indie", "indie pop", "la indie", "pov: indie"],
  },
  {
    band: "Age Factory",
    description: "Age Factory is a Japanese rock band formed in Nara in 2010 by vocalist and guitarist Eisuke Shimizu and bassist and backing vocalist Naoto Nishiguchi with drummer and backing vocalist Nakato Mashiko joining in 2014. They are still based in Nara, their hometown.",
    genre: ["j-rock", "japanese alternative rock"],
  },
  {
    band: "yobai suspects",
    description: "A music group that chews soul music / AOR / folk rock / pop music and spits them out with a wonder singing spirits. The voice which seems to have been given at the expense of something has stimulated many creators as well as musicians and continues to increase the crew of night cruises.",
    genre: ["r&b", "rnb", "soul", "funk", "aor", "folk rock", "pop"],
  },
  {
    band: "Hikaru Utada",
    description: "Hikaru Utada, known as 'Utada' in the U.S., is a Japanese-American singer-songwriter and producer. Her distinct sound blends pop, R&B, and electronic music, often marked by her emotive vocals and insightful lyrics.",
    genre: ["j-pop", "r&b", "pop"],
  },
  {
    band: "Ginger Root",
    description: "Under the moniker 'Ginger Root', multi-instrumentalist, producer, and songwriter Cameron Lew fronts a sound, self-proclaimed as: Aggressive elevator soul.",
    genre: ["hypnagogic pop", "oc indie", "indie"],
  },
  {
    band: "Yaeji",
    description: "Born in Flushing, Queens in 1993, Yaeji has roots in Seoul, Tokyo, Atlanta, and New York City, all serving as the backdrop for her singular, hybrid-sound that synthesizes influences of Korean indie rock and electronica, late ‘90s and early 2000s hip hop and R&B, and leftfield bass and techno.",
    genre: ["alternative r&b", "art pop", "escape room", "experimental house"],
  },
  {
    band: "The Avalanches",
    description: "There are few living musicians as influential and wholly original as world-renowned recording artists, producers and DJs, The Avalanches.",
    genre: ["alternative dance", "australian alternative rock", "australian dance", "collage pop", "electronica", "indietronica", "psychedelic hip hop"],
  },
  {
    band: "ONJUICY",
    description: "Starting in Tokyo in 2016, ONJUICY gained recognition with live performances and music releases, including the crossover hit 'PAM!!!' in collaboration with producer Carpainter.",
    genre: ["japanese underground rap"],
  },
  {
    band: "Demsky",
    description: "Hailing from Toronto, Canada and currently based in Tokyo, Demsky stands as a rising beatmaker who has swiftly carved his niche in the global music scene. His ambient and downtempo soundscapes have garnered acclaim, resonating with audiences across Asia and Europe.",
    genre: ["ambient"],
  },
  {
    band: "Veronica Veronico",
    description: "Alternative Cinematic Rock Band From Tokyo",
    genre: ["alternative rock", "rock"],
  },
  {
    band: "ANCIENT MYTH",
    description: "Japanese Female Fronted Symphonic Metal",
    genre: ["japanese power metal", "kawaii metal"],
  },
  {
    band: "Orca-Luca",
    description: "Melodic pop rock with emo influences and phenomenal harmonies.",
    genre: ["emo rock", "emo punk"],
  },
  {
    band: "ampcharwar",
    description: "Ampcharwar is a band performing in Tokyo. We are mixing together heavy rhythm and uncategorized music intensified by going through amps.",
    genre: ["indie", "rock"],
  },
  {
    band: "falls",
    description: "From Kichijoji, Tokyo, formed in early 2012. Three dudes lament and sing their anger and emptiness.",
    genre: ["emo", "math rock", "midwest emo"],
  },
  {
    band: "ANORAK!",
    description: "Based in Tokyo. 'SUPERNICEBOYS' 1st Full Album 'ANORAK!' OUT Nov 16, 2022",
    genre: ["japanese emo", "emo"],
  },
  {
    band: "envy",
    description: "Since forming in the early '90s, Envy have become one of Japan's premier exports to the international post-hardcore scene. Their experimental, cinematic approach to heavy melodic rock has made them a favorite of post-rock and alternative metal fans, and their intense, emotionally direct vocals and lyrics have won them accolades in the emo/screamo worlds as well.",
    genre: ["japanese emo", "japanese post-hardcore", "japanese post-rock", "japanese screamo", "post-rock"],
  },
  {
    band: "Taichi Mukai",
    description: "Taichi Mukai (向井太一, Mukai Taichi, born 13 March 1992) is a Japanese singer, songwriter and model from Fukuoka.",
    genre: ["japanese r&b", "r&b"],
  },
  {
    band: "EDEN KAI",
    description: "Eden Kai (real name: Yusuke Aizawa, born September 24, 1998) is a guitarist, ukulele player, singer-songwriter, and actor from Hachioji, Tokyo.",
    genre: ["pop", "acoustic", "ukelele"],
  },
  {
    band: "Asunojokei",
    description: "Formed in 2014. Tokyo-based post-black metal band. In 2022, they released their 2nd album 'Island', which received a great response both in Japan and abroad. In 2023, they will accompany Boris on their EU/UK tour.",
    genre: ["blackened screamo", "japanese black metal"],
  },
  {
    band: "高橋ユキヒロ",
    description: "Yukihiro Takahashi was a Japanese singer-songwriter, drummer, record producer, fashion designer, and writer.",
    genre: ["pop"],
  },
  {
    band: "満島高子",
    description: "Jazz musician based in Tokyo, Japan.",
    genre: ["japanese jazz", "jazz"],
  },
  {
    band: "Really From",
    description: "Drawing on influences of jazz improvisation, minimalist composition, and punk rock ethos, the Boston-based band Really From dismiss traditional genre and formulae in favor of explorative, indie rock amalgamations.",
    genre: ["5th wave emo", "boston indie", "new england emo", "emo"],
  },
  {
    band: "hazymoon",
    description: "Hello, World!! We are Chill Bossa Collective 'hazymoon' from Tokyo",
    genre: ["jazz"],
  },
  {
    band: "Grapchar",
    description: "Piano and Guitar music. Based in Tokyo, Japan. With background of the jazz and classic, music for anytime anywhere.",
    genre: ["jazz", "japanese jazz"],
  },
  {
    band: "sugarwraith",
    description: "As a Las Vegas artist currently living in Japan, sugarwraith combines emo influence with hyperpop and kawaii aesthetic.",
    genre: ["hyperpop"],
  },
  {
    band: "くだらない1日",
    description: "Originally founded in Fukuoka, Japan in 2016, Kudaranai 1 Nichi is a Tokyo-based indie rock band consisting of vocalist / guitarist Takane, guitarist Taiyo, bassist Kawai.",
    genre: ["japanese emo", "emo", "indie"],
  },
  {
    band: "YMCK",
    description: "YMCK is the Chiptune (8-bit pop) unit formed by 3 persons. The most prominent feature of the band is the 8bit sound that reminds people old game consoles, which attracts the enthusiastic support from wide range of generations.",
    genre: ["bitpop", "chiptune", "shibuya-kei"],
  },
  {
    band: "Aphex Twin",
    description: "Aphex Twin, the alias of Richard D. James, is a British electronic music pioneer known for his innovative and diverse styles, including ambient, IDM, and techno. His influential albums like Selected Ambient Works 85-92 and Drukqs showcase complex rhythms and experimental sound design, while his unique visuals and enigmatic persona add to his lasting impact on electronic music.",
    genre: ["braindance", "uk experimental electronic", "electronica", "ambient", "intelligent dance music", "electronic"],
  },
  {
    band: "BADBADNOTGOOD",
    description: "BadBadNotGood is a Canadian jazz and instrumental hip-hop group known for blending traditional jazz with modern genres. Their music features a mix of improvisation, groove-based rhythms, and collaborations with artists across hip-hop, electronic, and R&B. They’ve gained acclaim for their dynamic live performances and innovative approach to jazz, with notable albums including BBNG and IV.",
    genre: ["canadian modern jazz", "indie soul", "modern jazz", "nu jazz"],
  },
  {
    band: "Mannequin Pussy",
    description: "Mannequin Pussy is an American punk rock band from Philadelphia known for their raw, emotive sound and powerful live performances. Their music blends elements of punk, indie rock, and emo, characterized by intense vocals, dynamic guitar work, and introspective lyrics.",
    genre: ["bubblegrunge", "grunge", "indie punk", "punk", "riot grrrl", "modern power pop", "modern hardcore", "pop"],
  },
  {
    band: "Jamiroquai",
    description: "Jamiroquai is a British funk and acid jazz band formed in 1992, led by singer Jay Kay. Known for their fusion of funk, jazz, and electronic music, they gained popularity with their groovy, danceable sound and stylish visuals.",
    genre: ["dance pop", "dance", "pop", "funk", "jazz", "electronic", "acid jazz"],
  },
  {
    band: "Sabrina Carpenter",
    description: "Sabrina Carpenter is an American singer, songwriter, and actress. As a musician, her pop and pop-rock music features catchy melodies and personal lyrics. Carpenter's blend of youthful energy and lyrical introspection has made her a rising star in both music and entertainment.",
    genre: ["pop"],
  },
  {
    band: "Daft Punk",
    description: "Formed in 1993, Daft Punk, consisting of the duo Thomas Bangalter and Guy-Manuel de Homem-Christo—were famous for their iconic robotic personas and groundbreaking albums like Homework and Discovery. Their innovative sound, combining catchy beats with complex production, helped shape the modern electronic music landscape.",
    genre: ["electro", "filter house", "rock", "electronic", "french house"],
  },
  {
    band: "Team TokyoScene",
    description: "The team that worked on the development of the app TokyoScene. It consists of Yoosun, project manager; Erika, Lead Back-End Dev; Dianna, Lead Dev; and Senie, Lead Front-End Dev.",
    genre: ["rubycore"],
  },
]
puts "#{bands.count} bands added to the database!"

event_names = [
  "NeuroSync", "Future Frequencies", "ElectroPulse", "Echoes of Serenity", "IDM Horizons", "Electric Vibes", "Tokyo Tranquility", "Alt-Rock Surge", "Heartfelt Nights", "Indie Rock Rally", "Pop Fever", "Unplugged Evenings", "Uke Fest", "Punk Frenzy", "Rock Titan", "Metalstorm", "J-Pop Spectacle", "Rhythm & Groove", "Tokyo Alt-Pop", "Indietronica Blast", "Shibuya Beats", "Mystery Sounds", "Garage Riot", "SDA Vocal Showcase", "Sacred Harmony", "Electro Pulse", "Funk Fever", "Soul Essence", "House Beats", "Shoegaze Dreams", "Indie Fusion", "Dance Pop Delight", "Dance Fever", "Jazz Nights", "Acid Jazz Groove", "Grunge Revival", "Punk Storm", "J-Punk Clash", "Tokyo Jazz Vibes", "Canadian Jazz Flow", "Indie Soul Waves", "Modern Jazz Pulse", "Nu Jazz Bliss", "Bubblegrunge Bash", "Indie Punk Explosion", "Riot Grrrl Rage", "Power Pop Surge", "Hardcore Pulse", "Rock Legends", "K-Pop Extravaganza", "K-Pop Queens", "K-Indie Showcase", "Japanese Emo Vibes", "Post-Rock Horizons", "Tokyo Shoegaze", "Screamo Storm", "Black Metal Night", "Post-Hardcore Fury", "Screamo Fest", "Skramz Showcase", "K-Indie Rock Fest", "Korean City Pop Groove", "Art Pop Showcase", "Brooklyn Indie Bash", "Chamber Pop Gala", "Countrygaze Festival", "Indie Pop Fest", "Small Room Sessions", "Math Rock Madness", "Midwest Emo Night", "Neo-Psychedelic Journey", "Underground Rap Tokyo", "Hypnagogic Pop Dreams", "OC Indie Explosion", "Funk Rock Fusion", "Rubycore Live", "Alt-Rock Tokyo", "Indie Pop Tokyo", "Post-Rock Expedition", "Bedroom Pop Bliss", "Experimental Pop Night", "Post Punk Pulse", "Boat Punk Party", "Krautrock Echoes", "Psychedelic Rock Tokyo", "Neo-Kraut Grooves", "Bitpop Bonanza", "Chiptune Festival", "Progressive Rock Odyssey", "Post Rock Vibes", "Glitchbreak Beats", "J-Idol Showcase", "J-Pop Queens Live", "Electropop Tokyo", "Picopop Festival", "Disco Punk Blast", "Post-Hardcore Rampage", "Dream Pop Tokyo", "Korean Indie Folk Fest", "Alternative R&B Vibes", "Escape Room Beats", "Experimental House Night", "Metal Madness", "City Pop Celebration", "J-Rock Fever", "Emo Rock Rebellion", "Emo Punk Riot", "Rap Power",
]

# Method to generate a nickname based on the band name
def generate_nickname(band_name)
  band_name.split.join
end

# Create users for each band and store them in the bands array
bands.each_with_index do |band_info, index|
  email = "#{generate_nickname(band_info[:band])}-#{index + 1}@tokyoscene.me"
  user = User.create!(band_name: band_info, email: email, password: "123456", nickname: generate_nickname(band_info[:band]), is_band: true)
  band_info[:user] = user
  user.save!
  puts "#{band_info[:band]} - #{email} - user created!"
end

gig_time_from = Faker::Time.between(from: DateTime.now, to: 30.days.from_now)
gig_time_to = gig_time_from + 4.hours
# Create gig for each livehouse
livehouses.each do |livehouse|
  band_info = bands.sample # create a gig for each band
  matching_event_names = Gig.matching_event_names(event_names, band_info[:genre])
  matching_event_name = matching_event_names.sample || event_names.sample # Fallback to a random event name if no match

  gig = Gig.create!(
    user: band_info[:user], # Associate the user with the gig
    band: band_info[:band],
    date: Faker::Date.between(from: Date.today, to: 30.days.from_now),
    time_from: gig_time_from,
    time_to: gig_time_to,
    description: band_info[:description],
    location: livehouse[:address],
    location_name: livehouse[:livehouse],
    event_name: matching_event_name,
  )
  gig.genre_list.add(band_info[:genre])
  gig.save!
  puts "Created gig for #{band_info[:band]} at #{livehouse[:livehouse]}"
end

# Find or create the user with the band name "Team TokyoScene"
# Bonus TokyoScene event!
tokyoscene_event_time_from = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 18, 30)
tokyoscene_event_time_to = tokyoscene_event_time_from + 2.hours
# Fetch the last Livehouse record (Impact Hub)
impact_hub = livehouses.last

# Get the location and address of the last Livehouse
impact_hub_location = impact_hub[:livehouse]
impact_hub_location_name = impact_hub[:address]

team_tokyo_scene_gig = Gig.create!(
  user: User.last,
  band: "Team TokyoScene",
  date: Date::today,
  time_from: tokyoscene_event_time_from, # 6:30 PM
  time_to: tokyoscene_event_time_to, # 8:30
  location: impact_hub_location,
  location_name: impact_hub_location_name,
  event_name: "LeWagon Demo Day - Team TokyoScene",
)
team_tokyo_scene_gig.save!

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
tokyoscene_gig = gigs.last

# Loop through each user and create registrations for both gigs
created_users.each do |user|
  Registration.create!(user_id: user.id, gig_id: first_gig.id)
  Registration.create!(user_id: user.id, gig_id: second_gig.id)
  Registration.create!(user_id: user.id, gig_id: tokyoscene_gig.id)
end

puts "Created #{User.count} users!"
puts "Created #{Gig.count} gigs!"
puts "Created #{Registration.count} registrations!"
puts "Created #{Chatroom.count} chatrooms!"
