class HomesController < ApplicationController
  PER = 5

  def top
    #boards = Board.all
    @boards = Board.page(params[:page]).per(PER)
    @active_posts = Post.limit(8).order("created_at DESC")
  end

end
