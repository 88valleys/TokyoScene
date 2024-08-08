class RegistrationsController < ApplicationController
    def new
        @gig = Gig.find(params[:gig_id])
        @registration = @gig.registrations.new
    end
end
