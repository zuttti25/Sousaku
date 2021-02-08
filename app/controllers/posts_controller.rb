class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
    @like = Like.new
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
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to posts_path
      flash[:notice] = "商品を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :product, :category_id, :link).merge(user_id: current_user.id)
  end

end
