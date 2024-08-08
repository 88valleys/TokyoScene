class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
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
