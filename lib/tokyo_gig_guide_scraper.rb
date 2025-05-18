require "open-uri"
require "nokogiri"
require "date"
require "httparty"
require "csv"
require "ruby-progressbar"
require "time"

class TokyoGigGuideScraper
  BASE_URL = "https://www.tokyogigguide.com/en/gigs"
  FAILED_GEOCODES_FILE = "failed_geocodes.csv"
  @@failed_geocodes = []

  def self.scrape_upcoming_gigs
    gigs = []
    offset = 0
    today = Date.today
    max_gigs = 100
    start_time = Time.now

    puts "⏳ Scraping started at #{start_time.strftime("%H:%M:%S")}"
    progressbar = ProgressBar.create(title: "Gigs Scraped", total: max_gigs, format: "%t |%B| %c/%C")

    loop do
      url = "#{BASE_URL}?start=#{offset}"
      puts "📆 Scraping: #{url}"

      page_gigs = scrape_page(url, today, progressbar)
      break if page_gigs.empty?

      gigs += page_gigs
      offset += 50
      break if gigs.size >= max_gigs

      sleep 2
    end

    save_failed_geocodes

    end_time = Time.now
    duration = end_time - start_time
    puts "✅ Done scraping #{gigs.size} gigs at #{end_time.strftime("%H:%M:%S")} (⏱ #{duration.round}s total)"

    gigs[0...max_gigs]
  end

  def self.scrape_page(url, cutoff_date, progressbar)
    begin
      html = URI.open(url)
    rescue OpenURI::HTTPError => e
      puts "⚠️ Skipping #{url} (#{e.message})"
      return []
    end

    doc = Nokogiri::HTML(html)
    event_items = doc.css("li.jem-event")
    puts "🔍 Found #{event_items.count} gigs on this page."

    gigs = []

    event_items.each do |gig_html|
      break if progressbar.finished?

      date_meta = gig_html.at_css("meta[itemprop='startDate']")&.[]("content")
      date = DateTime.parse(date_meta) rescue nil
      next unless date && date.to_date >= cutoff_date

      title_text = gig_html.at_css("h4 a")&.text&.strip
      band_names = title_text.split(",").map(&:strip)
      main_band = band_names.first
      full_band_list = title_text

      event_name = full_band_list
      detail_path = gig_html.at_css("h4 a")&.[]("href")
      detail_url = "https://www.tokyogigguide.com#{detail_path}"

      band_image_url = gig_html.at_css(".jem-list-img img")&.[]("src")
      location_name = gig_html.at_css("a[href*='/gigs/venue']")&.text&.strip
      location_info = gig_html.css(".jem-event-info").find { |el| el["title"]&.include?("Area:") }
      location = location_info&.text&.strip
      location = "Tokyo" if location.blank?

      genre = gig_html.css(".fa-tag + a").map(&:text).map(&:strip)

      description = scrape_description(detail_url)
      sleep 1  # throttle between gig detail page visits

      latitude, longitude = geocode_location(location_name, location)

      gigs << Gig.new(
        band: main_band,
        event_name: event_name,
        band_image_url: band_image_url,
        date: date,
        time_from: date,
        description: description,
        genre_list: genre,
        location_name: location_name,
        location: location,
        latitude: latitude,
        longitude: longitude,
        user: User.first,
      )

      progressbar.increment
    end

    gigs
  end

  def self.scrape_description(detail_url)
    html = URI.open(detail_url)
    doc = Nokogiri::HTML(html)
    desc = doc.at_css(".jem-description")&.text&.strip
    desc || ""
  rescue
    ""
  end

  def self.geocode_location(location_name, area)
    api_key = ENV["OPENCAGE_API_KEY"]
    return [nil, nil] unless api_key

    queries = [
      "#{location_name}, #{area}, Tokyo, Japan",
      "#{location_name}, Tokyo, Japan",
      "#{area}, Tokyo, Japan",
    ]

    queries.each do |query|
      encoded_query = URI.encode_www_form_component(query)
      url = "https://api.opencagedata.com/geocode/v1/json?q=#{encoded_query}&key=#{api_key}"

      begin
        response = HTTParty.get(url)
        result = response.parsed_response["results"]&.first

        if result
          lat = result["geometry"]["lat"]
          lng = result["geometry"]["lng"]
          puts "✅ Geocoded: #{query} → [#{lat}, #{lng}]"
          return [lat, lng]
        end
      rescue => e
        puts "❌ Error geocoding #{query}: #{e.message}"
      end

      sleep 1  # throttle geocoding attempts
    end

    puts "⚠️ Failed to geocode: #{location_name}, #{area}"
    @@failed_geocodes << [location_name, area]
    [nil, nil]
  end

  def self.save_failed_geocodes
    return if @@failed_geocodes.empty?

    CSV.open(FAILED_GEOCODES_FILE, "w") do |csv|
      csv << ["Location Name", "Area"]
      @@failed_geocodes.each do |entry|
        csv << entry
      end
    end

    puts "💾 Saved #{@@failed_geocodes.size} failed geocode queries to #{FAILED_GEOCODES_FILE}"
  end
end
