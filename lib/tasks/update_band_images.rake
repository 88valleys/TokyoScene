# lib/tasks/update_band_images.rake
namespace :gigs do
  desc "Update band image URLs for existing Gig records"
  task update_band_images: :environment do
    Gig.find_each do |gig|
      gig.fetch_band_image
      gig.save!
      puts "Updated band image for #{gig.band}"
    end
  end
end