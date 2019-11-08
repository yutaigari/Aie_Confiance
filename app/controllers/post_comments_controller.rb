class PostCommentsController < ApplicationController
  before_action :authenticate_user!
    
  def create
    post_comment = current_user.post_comments.new(post_comment_params)
    post_image = PostImage.find(params[:post_image_id])
    post_comment.post_image_id = post_image.id
    if post_comment.save
      flash[:success] = "コメントしました"
      redirect_to post_image_url(post_image)
    else
      @post_image = PostImage.find(params[:post_image_id])
      @post_comment = PostComment.new
      flash.now[:alert] = "２文字以上100文字以下でコメントしてください"
      render '/post_images/show'
    end
  end
  
  def destroy
    post_image = PostImage.find(params[:post_image_id])
    post_comment = PostComment.find_by(post_image_id: post_image.id)
    post_comment.destroy
    flash[:success] = "コメントを消去しました"
    redirect_to post_image_url(post_image)
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :post_image_id)
  end
end
