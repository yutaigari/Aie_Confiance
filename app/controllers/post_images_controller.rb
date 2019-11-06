class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
    
  def new
    @post_image = PostImage.new
  end
  
  def create
    post_image = PostImage.new(post_image_params)
    post_image.user_id = current_user.id
    if post_image.save
      flash[:success] = "Post created!"
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end
  
  def destroy
  
  end
  
  def index
    @post_images = PostImage.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  private
  def post_image_params
    params.require(:post_image).permit(:content, :post_img_name)
  end
end
