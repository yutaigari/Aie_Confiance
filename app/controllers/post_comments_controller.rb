class PostCommentsController < ApplicationController
    
  def create
    post_comment = current_user.post_comments.new(post_comment_params)
    post_image = PostImage.find(params[:post_image_id])
    post_comment.post_image_id = post_image.id
    if post_comment.save
      flash[:success] = "Comment created!"
      redirect_to post_image_path(post_image)
    else
      flash[:danger] = "error"
      @post_image = PostImage.find(params[:post_image_id])
      @post_comment = PostComment.new
      render 'post_images/show'
    end
  end
  
  def destroy
      
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id, :post_image_id)
  end
end
