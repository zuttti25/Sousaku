class HomesController < ApplicationController

  def top
      @users = User.all
      @pickup = Post.limit(8).order("created_at DESC")
      @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
      @boards = Board.page(params[:page]).per(4).order("created_at DESC")
    #@boards = Board.all
  end

end
