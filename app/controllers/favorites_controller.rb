class FavoritesController < ApplicationController
  before_action :authenticate_user!
    
  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: @post_image.id)
    favorite.save
    respond_to do |format|
      format.html {redirect_to post_image_url(@post_image)}
      format.js
    end
  end
  
  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: @post_image.id)
    favorite.destroy
    respond_to do |format|
      format.html {redirect_to post_image_url(@post_image)}
      format.js
    end
  end
  
end
