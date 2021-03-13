class CommentsController < ApplicationController

def new
  @comment = Comment.new
  @post = Post.find(params[:post_id])
end


def create
    @post = Post.find(params[:post_id])
    #投稿に紐づいたコメントを作成
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_post = @comment.post
    @comment.save
      #通知の作成
    @comment_post.create_notification_comment!(current_user, @comment.id)
      #redirect_back(fallback_location: root_path)
end

def destroy
  @post = Post.find(params[:post_id])
  @comment = Comment.find(params[:id])
  @comment.destroy
end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end