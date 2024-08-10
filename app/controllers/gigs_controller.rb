class GigsController < ApplicationController

  def index
    @gigs = Gig.all

    @locations = @gigs.map(&:location).uniq
    @genres = ActsAsTaggableOn::Tag.all

    if params[:query].present?
      @gigs = @gigs.search_by_name_and_description_and_location(params[:query])
      flash[:notice] = "There are no results for the search" if @gigs.empty?
    end

    # @gigs = @locations.where(title: params[:query]) if params[:query].present?
    @gigs = @gigs.where(location: params[:location]) if params[:location].present?
    @gigs = @gigs.tagged_with(params[:genre]) if params[:genre].present?

    @markers = @gigs.geocoded.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "gigs/gigs", locals: { gig: gig }),
      }
    end
  end
end
