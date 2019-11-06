class UsersController < ApplicationController
    
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.paginate(page: params[:page], per_page: 4)
  end
  
end
