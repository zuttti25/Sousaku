class HomesController < ApplicationController

  def top
      @active_posts = Post.limit(8).order("created_at DESC")
      @boards = Board.page(params[:page]).per(4).order("created_at DESC")
    respond_to do |format|
      format.html
      format.js
    end
    #@boards = Board.all
  end

end
