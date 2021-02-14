class LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    # いいねの作成
    like = current_user.likes.new(post_id: @post.id)
    like.save
    
    #通知の作成
    #@post.create_notification_like!(current_user)
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    #redirect_back(fallback_location: root_path)
  end
end
