class RegistrationsController < ApplicationController
  def confirm
    @gig = Gig.find(params[:gig_id])
  end

  def create
    @gig = Gig.find(params[:gig_id])
    @registration = Registration.new
    @registration.gig = @gig
    @registration.user = current_user
    if @registration.save
      redirect_to confirm_gig_registrations_path(@gig), notice: "Registration was successfully created."
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit()
  end
end
