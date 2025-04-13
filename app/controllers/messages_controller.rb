class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user

    if @message.save
      begin
        ChatroomChannel.broadcast_to(
          @chatroom,
          {
            user: @message.user.name,
            content: @message.content,
            created_at: @message.created_at.strftime("%H:%M")
          }
        )
        head :ok
      rescue StandardError => e
        Rails.logger.error "Broadcasting failed: #{e.message}"
        flash[:alert] = "Message sent, but broadcasting failed."
        redirect_to chatroom_path(@chatroom)
      end
    else
      Rails.logger.error "Message save failed: #{@message.errors.full_messages.join(', ')}"
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
