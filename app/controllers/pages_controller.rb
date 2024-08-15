class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @gigs = Gig.all

    @locations = @gigs.map(&:location).uniq
    
    # WUP
    Rails.logger.debug "Genre parameter: #{params[:genre]}"

    genre = params[:genre]
    if genre
      decoded_genre = CGI.unescape(genre)
      Rails.logger.debug "Decoded genre: #{decoded_genre}"
      @genres = ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{decoded_genre}%")
    else
      @genres = ActsAsTaggableOn::Tag.all
    end

    # Updated so that the search query looks for band
    if params[:query].present?
      @gigs = @gigs.where("band LIKE ?", "%#{params[:query]}%")
    end

    # @gigs = @locations.where(title: params[:query]) if params[:query].present?
    @gigs = @gigs.where(location: params[:location]) if params[:location].present?
    @gigs = @gigs.tagged_with(params[:genre]) if params[:genre].present?

    @markers = @gigs.map do |gig|
      {
        lat: gig.latitude,
        lng: gig.longitude,
        info_window_html: render_to_string(partial: "gigs/gigs", locals: { gig: gig }),
      }
    end
  end
end
