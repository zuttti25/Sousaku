class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
      if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(message_params)
      #@messages = Message.all
      #@messages = Message.where("(user_id = ?) OR (user_id = ?)",user_id, current_user.id)
      redirect_to "/rooms/#{@message.room_id}"
      else
      redirect_back(fallback_location: root_path)
      end
  end

  def destroy

    message = Message.find_by(user_id: current_user.id)
    message.destroy
    #redirect_back(fallback_location: root_path) 非同期化に伴いコメントアウト
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(:user_id => current_user.id)
  end

end