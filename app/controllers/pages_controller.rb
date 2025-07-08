class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @locations = ["Shibuya", "Shinjuku", "Koenji", "Shimokitazawa", "Asagaya", "Meguro"]
    @gigs = Gig.all
    @registration = Registration.new

    # Initialize @genres

    # Retrievees all the unique genres from the database
    unique_genres = ActsAsTaggableOn::Tag.for_context("genre").pluck(:name).map(&:downcase).uniq
    @genres = unique_genres.map { |genre| ActsAsTaggableOn::Tag.find_or_create_by(name: genre) }.sort_by(&:name)

    # Search by gig's location, name, and band
    if params[:query].present?
      @gigs = @gigs.search_by_name_and_location(params[:query])
    end

    # recommend gigs
    if current_user
      if current_user.fav_genres.present?
        @gigs = @gigs.tagged_with(current_user.fav_genres)
      end
    end

    # Filter by genre
    @gigs = @gigs.tagged_with(params[:genre]) if params[:genre].present?

    # Filter by date
    @gigs = filter_by_date(@gigs, params[:date_range]) if params[:date_range].present?

    # Set map markers
    @markers = @gigs.geocoded.map do |gig|
      { lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "gigs/gigs", locals: { gig: gig }),
        marker_html: render_to_string(partial: "gigs/marker", locals: { gig: gig }) }
    end

    flash[:notice] = "There are no results for the search" if @gigs.empty?
  end

  private

  def filter_by_date(gigs, date)
    case date
    when "tonight"
      gigs.where("date >= ? AND date < ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
    when "this_weekend"
      end_of_weekend = Time.zone.now.end_of_week(:monday)
      start_of_weekend = (end_of_weekend - ((end_of_weekend.wday - 5) % 7).days).beginning_of_day
      gigs.where("date >= ? AND date < ?", start_of_weekend, end_of_weekend)
    when "this_month"
      gigs.where("date >= ? AND date < ?", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    when "next_month"
      start_of_next_month = Time.zone.now.next_month.beginning_of_month
      end_of_next_month = start_of_next_month.end_of_month
      gigs.where("date >= ? AND date < ?", start_of_next_month, end_of_next_month)
    else
      gigs
    end
  end
end
