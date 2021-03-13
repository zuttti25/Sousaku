  class RelationshipsController < ApplicationController
  
    def create
      @user = User.find(params[:follow_id])
      following = current_user.follow(@user)
        following.save
        @user.create_notification_follow!(current_user)
    end
    
    def destroy
      @user = User.find(params[:follow_id])
      following = current_user.unfollow(@user)
        following.destroy
    end

    def followings
      user = User.find(params[:id])
      @users = user.followings
    end
  
    def followers
      user = User.find(params[:id])
      @users = user.followers
    end
  
  end