class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @gigs = Gig.all
    @locations = ["Shibuya", "Shinjuku", "Koenji", "Shimokitazawa", "Asagaya", "Meguro"]
    @genres = ActsAsTaggableOn::Tag.all

    # search by name, description, location
    if params[:query].present?
      @gigs = Gig.search_by_name_and_description_and_location(params[:query])
      flash[:notice] = "There are no results for the search" if @gigs.empty?
    end

    # filter by location
    @gigs = @gigs.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?

    # filter by genre
    @gigs = @gigs.tagged_with(params[:genre]) if params[:genre].present?

    # filter by date
    if params[:time].present?
      case params[:time]
      when 'tonight'
        @gigs = @gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
      when 'this_weekend'
        start_of_weekend = Time.zone.now.end_of_week(:mondey)
        end_of_weekend = start_of_weekend + 2.days
        @gigs = @gigs.where('time >= ? AND time < ?', start_of_weekend, end_of_weekend)
      when 'this_month'
        @gigs = @gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
      when 'next_month'
        start_of_next_month = Time.zone.now.next_month.beginning_of_month
        end_of_next_month = start_of_next_month.end_of_month
        @gigs = @gigs.where('time >= ? AND time < ?', start_of_next_month, end_of_next_month)
      end
    end

    # make sure that @gigs are not nil
    @gigs = [] if @gigs.nil?

    # set markers for the map
    if @gigs.any?
      @markers = @gigs.geocoded.map do |gig|
        {
          lat: gig.latitude,
          lng: gig.longitude,
          info_window_html: render_to_string(partial: "gigs/gigs", locals: { gig: gig })
        }
      end
    end

    @markers ||= [] # Ensure @markers is set to an empty array if there are no gigs
    flash[:notice] = "There are no results for the search" if @markers.empty?
  end
end
