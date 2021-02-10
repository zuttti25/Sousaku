class UsersController < ApplicationController
 
  def edit
    @user=User.find(params[:id])
  end

  def show
    @user=User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)  #@userが現在ログインしているユーザーではない場合
    #すでにroomsが"作成されている場合"と"作成されていない場合"に条件分岐
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|   
          if cu.room_id == u.room_id then  #ユーザー同士のルームIDを照合する
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom  #ログイン中のユーザーのroom_idがfalse（存在しない）の場合、新しくルームを作成する
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:image, :name, :introduction, :skill, :link)
  end

end
