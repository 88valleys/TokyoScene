class ChatroomsController < ApplicationController

  def index
    @chatrooms = current_user.chatrooms
  end
  # associate a chatroom with a gig
  def create
    @gig = Gig.find(params[:gig_id])
    @chatroom = @gig.build_chatroom(chatroom_params)
    if @chatroom.save
      redirect_to @chatroom
    else
      render :new
    end
  end
  def show
    @chatroom = Chatroom.find(params[:id])
    @gig = @chatroom.gig
    @message = Message.new
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name, :description)
  end
end
