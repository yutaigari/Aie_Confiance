class PostImagesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post_image = PostImage.new
  end
  
  def create
    post_image = PostImage.new(post_image_params)
    post_image.user_id = current_user.id
    if post_image.save
      flash[:success] = "投稿しました"
      redirect_to user_url(current_user)
    else
      @post_image = PostImage.new
      flash.now[:alert] = "読み取れる画像にしてください。または紹介文を2文字以上140文字以下にしてください"
      render :new
    end
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    flash[:success] = "投稿を消しました"
    redirect_to user_url(current_user)
  end
  
  def index
    @post_images = PostImage.paginate(page: params[:page], per_page: 5)
    #タグの絞り込み
    if params[:tag_name]
      @post_images = @post_images.tagged_with("#{params[:tag_name]}") 
    end
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  private
  def post_image_params
    params.require(:post_image).permit(:content, :user_id, {post_img_name: []}, :tag_list)
  end
  
end
