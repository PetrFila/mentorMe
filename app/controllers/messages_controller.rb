class MessagesController < ApplicationController
  def create
    {"content"=>"p", "chat_id"=>"1", "other_profile_id"=>"2"}
    message = Message.new(content: params[:message][:content], chat_id: params[:message][:chat_id])
    message.profile_id = current_user.profile.id
    puts "---#{message.inspect}"
    if message.save
      #broadcasting out to messages channel including the chat_id so messages are broadcasted to specific chat only
      ActionCable.server.broadcast( "messages_#{message_params[:chat_id]}",
        #message and user hold the data we render on the page using javascript
        message: message.content,
        user: message.profile.full_name
      )
    else
      # if error saving message, take us back to the other user's profiles chat window
      redirect_to profile_chat_path(params[:message][:other_profile_id], params[:message][:chat_id])
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :chat_id, :other_profile_id)
    end
end
