class HomesController < ApplicationController

  def top
    @boards = Board.page(params[:page]).per(5).order("created_at DESC")
    @active_posts = Post.limit(8).order("created_at DESC")
  end

end
