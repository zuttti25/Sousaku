  class RelationshipsController < ApplicationController
  
    def create
      @user = User.find(params[:follow_id])
      following = current_user.follow(@user)
      if following.save
        flash[:success] = 'ユーザーをフォローしました'
        @user.create_notification_follow!(current_user)
        redirect_back(fallback_location: :back)
      else
        flash.now[:alert] = 'ユーザーのフォローに失敗しました'
        redirect_back(fallback_location: :back)
      end
    end
    
    def destroy
      user = User.find(params[:follow_id])
      following = current_user.unfollow(user)
      if following.destroy
        flash[:success] = 'ユーザーのフォローを解除しました'
        redirect_back(fallback_location: :back)
      else
        flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
        redirect_back(fallback_location: :back)
      end
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