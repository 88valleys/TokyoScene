# lib/tasks/tokyo_gigs.rake

namespace :tokyo do
  namespace :gigs do
    desc "Scrape and save upcoming Tokyo gigs"
    task import: :environment do
      require Rails.root.join("lib/tokyo_gig_guide_scraper")

      puts "🎸 Importing upcoming gigs from Tokyo Gig Guide..."

      gigs = TokyoGigGuideScraper.scrape_upcoming_gigs

      gigs.each do |gig|
        if gig.save
          puts "✅ Saved: #{gig.band} on #{gig.date.strftime("%Y-%m-%d")} at #{gig.location_name}"
        else
          puts "⚠️ Skipped (invalid): #{gig.event_name}"
          puts "   Errors: #{gig.errors.full_messages.join(", ")}"
        end
      end

      puts "🎉 Done! Imported #{gigs.count} gigs."
    end
  end
end
