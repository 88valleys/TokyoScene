class RegistrationsController < ApplicationController
  def index
    @registrations = current_user.registrations.includes(gig: :chatroom)
  end

  def registrations
    @registrations = current_user.registrations.includes(:gig)
  end

  def confirm
    #@gig = Gig.find(params[:gig_id])
    @registrations = current_user.registrations.includes(:gig)
  end

  def create
    @gig = Gig.find(params[:gig_id])
    @registration = Registration.new
    @registration.gig = @gig
    @registration.user = current_user
    if @registration.save
      redirect_to chatroom_path(@gig.chatroom)
    else
      render :new
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    redirect_to dashboard_path, notice: "Unregistered from event"
  end

  private

  def registration_params
    params.require(:registration).permit()
  end
end
