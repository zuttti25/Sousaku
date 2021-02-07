class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
  end

  def edit
  end

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :product, :category_id).merge(user_id: current_user.id)
  end

end
