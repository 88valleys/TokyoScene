class GigsController < ApplicationController
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
    @genres = ActsAsTaggableOn::Tag.all
    @gigs = @locations.where(title: params[:query]) if params[:query].present?
    @gigs = @gigs.tagged_with(params[:genre])
  end
end
