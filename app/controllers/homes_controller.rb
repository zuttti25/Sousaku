class HomesController < ApplicationController

  def top
      @users = User.all
      @pickup = Post.limit(12).order("created_at DESC")
      @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
      @boards = Board.all.order("created_at DESC")
  end

  def about
  end

end
