class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @locations = ["Shibuya", "Shinjuku", "Koenji", "Shimokitazawa", "Asagaya", "Meguro"]
    @gigs = Gig.all
    @registration = Registration.new

    # Initialize @genres
    unique_genres = ["K-pop", "Indie Rock", "Soul", "Funk", "Funk Soul", "Alternative Rock", "Pop Rock", "Britpop", "Rock", "Soul Pop", "R&B", "Modern Soul", "Future Soul", "Psychedelic Soul", "Neo-Soul", "Pop", "Emo Rock"]
    @genres = unique_genres.map { |genre| ActsAsTaggableOn::Tag.find_or_create_by(name: genre) }

    # Search by gig's location and name(event_name)
    @gigs = @gigs.search_by_name_and_location(params[:query]) if params[:query].present?

    # recommend gigs
    if current_user
      if current_user.fav_genres.present?
        @gigs = @gigs.tagged_with(current_user.fav_genres)
      end
    else
      flash[:alert] = "You need to be logged in to get recommendations."
      redirect_to new_user_session_path and return
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
        marker_html: render_to_string(partial: "gigs/marker", locals: { gig: gig })
      }
    end

    flash[:notice] = "There are no results for the search" if @gigs.empty?
  end

  private

  def filter_by_date(gigs, time)
    case time
    when 'tonight'
      gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day)
    when 'this_weekend'
      end_of_weekend = Time.zone.now.end_of_week(:monday)
      start_of_weekend = (end_of_weekend - 1.day).beginning_of_day
      gigs.where('time >= ? AND time < ?', start_of_weekend, end_of_weekend)
    when 'this_month'
      gigs.where('time >= ? AND time < ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    when 'next_month'
      start_of_next_month = Time.zone.now.next_month.beginning_of_month
      end_of_next_month = start_of_next_month.end_of_month
      gigs.where('time >= ? AND time < ?', start_of_next_month, end_of_next_month)
    else
      gigs
    end
  end
end
