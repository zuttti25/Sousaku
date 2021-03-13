class HomesController < ApplicationController

  def top
     #開発環境はsqlight　の　order("RANDOM()")
      @users = User.all
      #.order("RANDOM()").limit(5)
      #本番環境はmysqlになるので
      #@users = User.all.order("RAND()").limit(5)

      @pickup = Post.limit(12).order("created_at DESC")
      @popular = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
      @boards = Board.all.order("created_at DESC")
  end

  def about
  end

end
