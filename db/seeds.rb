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
  { livehouse: "Circus Tokyo", address: "16, Shibuya 3, Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Club Asia", address: "Rambling Street, Maruyamacho, Shibuya, Tokyo, 155-0002, Japan" },
  { livehouse: "Contact", address: "12, Dogen-zaka Street, Dogenzaka 2, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Cyclone", address: "Penguin Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "Daitokai", address: "Matsudo Station Line, 本町, Matsudo, Chiba Prefecture, 271-0091, Japan" },
  { livehouse: "DUO Music Exchange", address: "Rambling Street, Maruyamacho, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "FabCafe", address: "1-22-7, Dogen-zaka Street, Maruyamacho, Shibuya, Tokyo, 150-0044, Japan" },
  { livehouse: "Galaxy (Shibuya)", address: "5-27-7, Cat Street, Jingumae 6, Jingūmae, Shibuya, Tokyo, 150-0001, Japan" },
  { livehouse: "Hobgoblin", address: "Omoide-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Home", address: "Nakasugi-dori Avenue, Saginomiya 4-chome, Nakano, Tokyo, 165-0032, Japan" },
  { livehouse: "Image Forum", address: "Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Kitsune", address: "2-20-13, Meiji-dori Avenue, Higashi, Higashi 2, Higashi, Shibuya, Tokyo, 150-0011, Japan" },
  { livehouse: "La Mama", address: "Shibuya Chuo-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "Line Cube Shibuya", address: "1, Udagawacho, Shibuya, Tokyo, 150-0771, Japan" },
  { livehouse: "Lush", address: "6, Shinjuku 3, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Music Bar 45", address: "Sakuragaokacho, Shibuya, Tokyo, 150-0031, Japan" },
  { livehouse: "NHK Hall", address: "1, Jinnan 2, Jinnan, Shibuya, Tokyo, 150-8001, Japan" },
  { livehouse: "NIGHTFLY", address: "Udagawacho, Shibuya, Tokyo, 150-8507, Japan" },
  { livehouse: "Oath", address: "9, Shibuya 4, Shibuya, Tokyo, 150-0002, Japan" },
  { livehouse: "Sankeys TYO", address: "Sarugakucho, Shibuya, Tokyo, 150-0033, Japan" },
  { livehouse: "Shibuya Ax", address: "Wave-dori Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0043, Japan" },
  { livehouse: "SHIBUYA REX", address: "Miyamasu-zaka Street, Shibuya 2, Shibuya, Tokyo, 150-8510, Japan" },
  { livehouse: "The Aldgate", address: "Shibuya Center-gai Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "The Room", address: "15-19, Sakuragaokacho, Shibuya, Tokyo, 150-0031, Japan" },
  { livehouse: "Tower Records Shibuya", address: "14, Jinnan 1, Jinnan, Shibuya, Tokyo, 150-0041, Japan" },
  { livehouse: "Womb", address: "16, Maruyamacho, Shibuya, Tokyo, 150-0044, Japan" },
  { livehouse: "WWW", address: "Spain-zaka Street, Udagawacho, Shibuya, Tokyo, 150-0042, Japan" },
  { livehouse: "翠月 (MITSUKI)", address: "Dogen-zaka Street, Dogenzaka 1, Dogenzaka, Shibuya, Tokyo, 150-0044, Japan" },
  # Asakusa
  { livehouse: "Cuzn Homeground", address: "Hisago-dori, Asakusa 2-chome, Asakusa, Taito, Tokyo, 111-0032, Japan" },
  { livehouse: "Infinity Books", address: "Asakusa-dori, Azumabashi 1, Azumabashi, Sumida, Tokyo, 130-0001, Japan" },
  # Shinjuku
  { livehouse: "8bit cafe", address: "御苑通り, Shinjuku 2, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Antiknock", address: "Meiji-dori Avenue, Shinjuku 4, Shinjuku, Tokyo, 151-8580, Japan" },
  { livehouse: "Cafe Lavanderia", address: "新宿2-12-9, Hanazono-dori, Shinjuku 2, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Christon Cafè", address: "Yasukuni-dori Avenue, Shinjuku 5, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Marz", address: "Ichiban-dori Street, Kabukicho 2, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  { livehouse: "Rosso", address: "4C's Bar Rosso, 1, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  { livehouse: "Spincoaster", address: "四谷角筈線, Yoyogi 2, Yoyogi, Nishi Shinjuku, Shibuya, Tokyo, 151-8583, Japan" },
  { livehouse: "Tokyo Opera City", address: "Yamate-dori Avenue, Honmachi 3, Nishi Shinjuku 3, Nishi Shinjuku, Shinjuku, Tokyo, 151-0071, Japan" },
  { livehouse: "Tower Records Shinjuku", address: "1, Shinjuku 3, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Wild Side Tokyo", address: "Yasukuni-dori, Shinjuku 5, Shinjuku, Tokyo, 160-0022, Japan" },
  { livehouse: "Zirco Tokyo", address: "Kuyakusho-dori Avenue, Kabukicho 1, Kabukicho, Shinjuku, Tokyo, 160-0021, Japan" },
  # Asagaya
  { livehouse: "mogumogu Asagaya", address: "Pearl Center Shika, Asagaya Pearl Center Shopping Street, Asagaya minami 1, Asagaya minami, Kōenji, Suginami, Tokyo, 166-8578" },
  { livehouse: "Gamuso", address: "Asagaya kita 2, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Art Bar Ten", address: "Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  { livehouse: "COOL DREAD BAR", address: "Asagaya kita 3, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Loft A", address: "Asagaya kita 1, Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  { livehouse: "Yellow Vision", address: "Asagaya kita 2, Asagaya kita, Suginami, Tokyo, Japan" },
  { livehouse: "Next Sunday", address: "Asagaya Shinmeiguu, Nakasugi dori Ave., Asagaya kita 1, Asagaya kita, Kōenji, Suginami, Tokyo, 166-0001, Japan" },
  # Akihabara
  { livehouse: "秋葉原 CLUB GOODMAN", address: "Kanda-Sakumagashi, Chiyoda, Tokyo, Japan" },
  { livehouse: "Akihabara Marz", address: "Kanda-Sakumacho 1-chome, Kanda-Sakumacho, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "Fukumori", address: "Kanda-Sudacho 1-chome, Kanda-Sudacho, Chiyoda, Tokyo, 101-0041, Japan" },
  { livehouse: "Akihabara ZEST", address: "Soto-Kanda 2, 外神田, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "TOKYOITE! the music space", address: "Soto-Kanda 2, 外神田, Chiyoda, Tokyo, 102-0000, Japan" },
  { livehouse: "NARU Jazz Livehouse", address: "Kanda-Surugadai 2-chome, Kanda-Surugadai, Chiyoda, Tokyo, 101-0062, Japan" },
  { livehouse: "BECK アキバ ライブハウス リハーサルスタジオ セッションバー", address: "Kanda-Sakumacho 2-chome, Kanda-Sakumacho, Chiyoda, Tokyo, 101-0025, Japan" },
  # Roppongi
  { livehouse: "SUPER DELUXE", address: "Nishiazabu-yonchome, Kogai-zaka Street, Roppongi 6-chome, Nishi-Azabu 4-chome, Azabu, Minato, Tokyo, 106-0031, Japan" },
  { livehouse: "BILLBOARD LIVE TOKYO", address: "Akasaka 9-chome, Akasaka, Azabu, Minato, Tokyo, 106-0032, Japan" },
  { livehouse: "六本木 CLUB EDGE", address: "Roppongi 5-chome, Roppongi, Azabu, Minato, Tokyo, 106-8537, Japan" },
  { livehouse: "EX THEATER ROPPONGI", address: "DUO SCALA NISHIAZABU TOWER, Roppongi-dori, Roppongi 6-chome, Nishi-Azabu 1-chome, Azabu, Minato, Tokyo, 106-0031, Japan" },
  { livehouse: "BAUHAUS", address: "アロービル, 7, Roppongi, Azabu, Minato, Tokyo, 106-0032, Japan" },
  { livehouse: "Jazz House ALFIE", address: "Roppongi 6-chome, Roppongi, Azabu, Minato, Tokyo, 106-8001, Japan" },
  { livehouse: "Common", address: "六本木Dスクエア, 5, Roppongi, Azabu, Minato, Tokyo, 106-0032, Japan" },
  # Ikebukuro
  { livehouse: "Live garage Adm", address: "Higashi-Ikebukuro 1-chome, Toshima, Tokyo, 170-0013, Japan" },
  { livehouse: "池袋 Live inn ROSA", address: "Nishi-Ikebukuro 1-chome, Toshima, Tokyo, 171-8504, Japan" },
  { livehouse: "Absolute Blue", address: "Nishi-Ikebukuro 1-chome, Toshima, Tokyo, 171-8504, Japan" },
  { livehouse: "Apple Jump", address: "Nishi-Ikebukuro 3-chome, Toshima, Tokyo, 171-0021, Japan" },
  { livehouse: "KAKULULU", address: "Higashi-Ikebukuro 4-chome, Toshima, Tokyo, 170-6002, Japan" },
  { livehouse: "INDEPENDENCE", address: "Nishi-Ikebukuro 3-chome, Toshima, Tokyo, 171-0021, Japan" },
  { livehouse: "池袋 LiveHouse mono", address: "South Ikebukuro, Toshima, Tokyo, Japan" },
  # Saitama
  { livehouse: "Saitama Super Arena", address: "Saitama Super Arena, Shintoshin, Chuo Ward, Saitama, Saitama Prefecture, 330-0081, Japan" },
  { livehouse: "HEAVEN'S ROCK さいたま新都心 VJ-3", address: "Kamiochiai 4-chome, Chuo Ward, Saitama, Saitama Prefecture, 338-0001, Japan" },
  { livehouse: "live 空舞台", address: "Higashi-Iwatsuki 4-chome, Iwatsuki Ward, Saitama, Saitama Prefecture, 339-0065, Japan" },
  { livehouse: "Narciss", address: "Takasago 2-chome, Urawa Ward, Saitama, Saitama Prefecture, 330-0063, Japan" },
  { livehouse: "MUSIC & LIVE BAR CITYLIGHTS", address: "Kamiochiai, Chuo Ward, Saitama, Saitama Prefecture, 330-0081, Japan" },
  { livehouse: "西川口 Live House Hearts", address: "Namiki 2-chome, Iwatsuki Ward, Saitama, Saitama Prefecture, 337-0002, Japan" },
  { livehouse: "ayers", address: "Tokiwa 9-chome, Urawa Ward, Saitama, Saitama Prefecture, 336-0074, Japan" },
  # Kichijoji
  { livehouse: "NEPO", address: "Shimorenjaku 1-chome, Mitaka, Tokyo, 181-0013, Japan" },
  { livehouse: "吉祥寺 SHUFFLE", address: "Kichijoji Minamicho, Musashino, Tokyo, 180-0003, Japan" },
  { livehouse: "Silver Elephant", address: "吉祥寺駅, Heiwa Dori, Kichijoji Honcho, Musashino, Tokyo, 180-8520, Japan" },
  { livehouse: "Black and Blue", address: "Kichijoji-honcho 1-chome, Musashino, Tokyo, 180-0004, Japan" },
  { livehouse: "Daydream Kichijoji", address: "Kichijoji, Heiwa Dori, Kichijoji-honcho 1-chome, Musashino, Tokyo, 180-8552, Japan" },
  { livehouse: "Strings", address: "Kichijoji Honcho, Musashino, Tokyo, 180-8520, Japan" },
  # Koenji
  { livehouse: "AG22", address: "AG22, 高南通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "AMP cafe", address: "AMP, Koenji Look Street, Koenji minami 2, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan " },
  { livehouse: "DJ's Bar Cave", address: "DJ's bar Koenji Cave, 高南通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Faith", address: "FAITH, Kannana-dori Avenue, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Higashi Koenji U.F.O.CLUB (UFO Club)", address: "Koenji Higashi 2-chome, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Knock (Koenji)", address: "Knock, 6, Koenji minami 3, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Koenji High", address: "Koenji High, 南中央通り, Koenji minami 4, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Oriental Force", address: "Oriental Force, 第８日東ビル, Koenji minami 3, Kōenji-south, Kōenji, Suginami, Tokyo, 166-0003, Japan" },
  { livehouse: "Penguin House", address: "PENGUIN HOUSE, 純情商店街, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Roots (Koenji)", address: "ROOTS!, Central Road, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "Higashi Koenji U.F.O.CLUB (UFO Club)", address: "Koenji Higashi 2-chome, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  { livehouse: "SUBstore Koenji", address: "SUBstore Tokyo, 高円寺中通り, Koenji kita 3, Kōenji-north, Kōenji, Suginami, Tokyo, 166-0002, Japan" },
  # Yokohama
  { livehouse: "1000 Club", address: "1000 CLUB, Minamisaiwai 2-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0005, Japan" },
  { livehouse: "El Puente ", address: "Minamisengencho, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0024, Japan" },
  { livehouse: "KT Zepp Yokohama", address: "KT Zepp Yokohama, 6, Minatomirai 4-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0012, Japan " },
  { livehouse: "Pacifico Yokohama", address: "PACIFICO Yokohama North, 2, Minatomirai 1-chome, Nishi Ward, Yokohama, Kanagawa Prefecture, 220-0012, Japan" },
  { livehouse: " Pia Arena MM", address: "PIA ARENA MM, 1, Nishi Ward, Yokohama, Kanagawa Prefecture, 231-0017, Japan" }
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

# Create gig for each livehouse
livehouses.each do |livehouse|
  band_info = bands.sample # Randomly select a band from the array
  gig = Gig.create!(
    user: band_info[:user], # Associate the user with the gig
    band: band_info[:band],
    time: Faker::Date.between(from: Date.today, to: 30.days.from_now),
    description: band_info[:description],
    location: livehouse[:address],
    location_name: livehouse[:livehouse],
    event_name: event_names.sample
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
  location: livehouses.map { |i| i[:address] },
  event_name: event_names.sample
)
tonight_gig.genre_list.add(band_info[:genre])
tonight_gig.save!

# Fetch all gigs
gigs = Gig.all

# Iterate over each gig and create a chatroom
gigs.each do |gig|
  chatroom = gig.build_chatroom(
    name: "#{gig.event_name}: #{gig.band}"
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
  { email: "erika@erika.com", password: "123456", nickname: "Erika" }
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
puts "Created #{Chatroom.count} chatrooms!"
