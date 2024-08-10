class GigsController < ApplicationController
  def show
    @gig = Gig.find(params[:id])
    @registration = Registration.new
  end
end
