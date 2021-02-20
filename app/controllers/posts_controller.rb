class PostsController < ApplicationController
  impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]


  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    #impressionist(@post, nil, unique: [:session_hash])
    # PV数を計る
    impressionist(@post, nil, unique: [:ip_address])
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
  end

  def index
    if params[:tag_id]
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: "DESC").page(params[:page]).per(10)
      @posts_side = Post.order(created_at: "DESC")
      @like = Like.new
    else
      @tag_list = Tag.all
      @posts = Post.order(created_at: "DESC").page(params[:page]).per(10)
      @posts_side = Post.order(created_at: "DESC")
      @like = Like.new
    end
      respond_to do |format|
        format.html
        format.rss { render :layout => false }
      end
  end


  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(",")
      if @post.save
      @post.save_posts(tag_list)
      redirect_to post_path(@post)
      else
        render :"posts/new"
      end
  end
  

  def update
    post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(",")
    if post.update(post_params)
      post.save_posts(tag_list)
      flash[:notice] = "更新しました。"
      redirect_to post_path(post)
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
    params.require(:post).permit(:image, :title, :product, :link).merge(user_id: current_user.id)
  end
end