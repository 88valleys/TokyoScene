class GigsController < ApplicationController
  def show
    @gig = Gig.find(params[:id])
    @registration = Registration.new
  end

  def index
    @gigs = Gig.all
  end
end
