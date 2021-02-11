class HomesController < ApplicationController

  def top
    @boards = Board.all
    @active_posts = Post.limit(10).order("created_at DESC")
  end

end
