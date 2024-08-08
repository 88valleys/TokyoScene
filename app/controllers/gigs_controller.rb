class GigsController < ApplicationController
<<<<<<< HEAD
  # def search
  #   @gigs = Gig.search_by_name_and_description_and_location(params[:query])
  # end

  def index
    if params[:query].present?
      @gigs = Gig.search_by_name_and_description_and_location(params[:query])
      flash[:notice] = "There are no results for the search" if @gigs.empty?
    else
      @gigs = Gig.all
    end
    @locations = @gigs.map(&:location).uniq
    @gigs = @locations.where(title: params[:query]) if params[:query].present?
=======
  def index
    @gigs = Gig.all
    @markers = @gigs.geocoded.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "layouts/info_window", locals: {gig: gig})
      }
    end  
>>>>>>> 21dde632db1d1424fd440839c5a3bfa1f4942db4
  end
end

