class GigsController < ApplicationController
  def index
    @gigs = Gig.all
    @markers = @gigs.geocoded.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "layouts/info_window", locals: {gig: gig})
      }
    end  
  end
end
