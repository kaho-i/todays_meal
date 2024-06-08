class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.user_id = current_user.id
    comment.save
    flash[:notice] = 'コメントしました'
    redirect_to request.referer
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to request.referer
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
end
