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

    # @locations = @gigs.map(&:location).uniq
    # @genres = ActsAsTaggableOn::Tag.all
    # # @gigs = @locations.where(title: params[:query]) if params[:query].present?
    # @gigs = Gig.where(location: params[:location]) if params[:location].present?
    # @gigs = @gigs.tagged_with(params[:genre])
=======

    def show
      @gig = Gig.find(params[:id])
    end

  def index
    @gigs = Gig.all
    @markers = @gigs.geocoded.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "gigs/gigs", locals: {gig: gig})
      }
    end  
>>>>>>> a5c11068814556050b00db249a691cc31afe1ec2
  end
end
