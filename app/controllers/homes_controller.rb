class HomesController < ApplicationController

  def top
      @users = User.limit(12).order("created_at DESC")
      @pickup = Post.limit(12).order("created_at DESC")
      @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(12).pluck(:post_id))
      @boards = Board.page(params[:page]).per(4).order("created_at DESC")
    #@boards = Board.all
  end
  
  def about
  end

end
