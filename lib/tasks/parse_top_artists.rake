# lib/tasks/parse_top_artists.rake
namespace :parse do
  desc "Parse top artists JSON and find top 10 genres"
  task top_artists: :environment do
    require "json"

    # Path to the JSON file
    file_path = Rails.root.join("db", "top_artists.json")

    # Read and parse the JSON file
    json_data = File.read(file_path)
    data = JSON.parse(json_data)

    # Initialize a hash to count genre occurrences
    genre_count = Hash.new(0)

    # Extract genres and count occurrences
    data["items"].each do |artist|
      artist["genres"].each do |genre|
        genre_count[genre] += 1
      end
    end

    # Sort genres by count in descending order and get the top 10
    top_genres = genre_count.sort_by { |genre, count| -count }.first(10).map(&:first)

    # Update the genre list for all users - this is just an example, you can modify this to suit your needs.
    User.find_each do |user|
      user.genre_list = top_genres
      user.save!
    end

    # Sort and output all genres and their counts
    puts "Senie's Spotify Genre List:"
    genre_count.sort_by { |genre, count| -count }.each do |genre, count|
      puts "#{genre}: #{count}"
    end

    # Output the top 10 genres
    puts "Top 10 genres:"
    top_genres.each do |genre|
      puts "#{genre}: #{genre_count[genre]}"
    end
  end
end
