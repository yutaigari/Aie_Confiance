class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.paginate(page: params[:page], per_page: 4)
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5).search(params[:search])
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page]) 
    render 'show_follow'
  end
  
  
end
