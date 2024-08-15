class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @locations = ["Shibuya", "Shinjuku", "Koenji", "Shimokitazawa", "Asagaya", "Meguro"]
    @gigs = Gig.all

    # Initialize @genres
    @genres = ActsAsTaggableOn::Tag.all

    p params
    # search by name, location
    if params[:query].present?
      @gigs = @gigs.search_by_name_and_location(params[:query])
      p @gigs
    end

    # filter by location
    if params[:location].present?
      @gigs = @gigs.where("location ILIKE ?", "%#{params[:location]}%")
    end

    # recommend gigs
    if current_user
      if current_user.fav_genres.present?
        @gigs = @gigs.tagged_with(current_user.fav_genres)
      end
    else
      flash[:alert] = "You need to be logged in to get recommendations."
      redirect_to new_user_session_path and return
    end

    # filter by genre
    if params[:genre].present?
      @gigs = @gigs.tagged_with(params[:genre])
    end

    # filter by date
    if params[:time].present?
      @gigs = filter_by_date(@gigs, params[:time])
    end

    # set map markers
    @markers = @gigs.geocoded.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "gigs/gigs", locals: { gig: gig })
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
      start_of_weekend = Time.zone.now.end_of_week(:mondey)
      end_of_weekend = start_of_weekend + 2.days
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
