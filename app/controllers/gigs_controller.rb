class GigsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def create
    @gig = Gig.new(gig_params)
    if @gig.save
      @gig.fetch_band_image
      redirect_to @gig, notice: "Gig was successfully created."
    else
      render :new
    end
  end

  def update
    @gig = Gig.find(params[:id])
    if @gig.update(gig_params)
      @gig.fetch_band_image
      redirect_to @gig, notice: "Gig was successfully updated."
    else
      render :edit
    end
  end

  def show
    @gig = Gig.find(params[:id])
    @registration = Registration.new
  end

  def index
    @gigs = Gig.all
  end

  def gig_params
    params.require(:gig).permit(:band, :description, :location, :band_image_url)
  end
end
