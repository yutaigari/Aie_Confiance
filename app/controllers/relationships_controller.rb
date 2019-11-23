class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:followed_id]) #form_forでfollowed_idが飛んでくる
    current_user.follow(user)
    redirect_to user
  end
  
  def destroy
    user = Relationship.find(params[:id]).followed #Relationshipのidを受け取る、routesをみれば見ればわかる
    current_user.unfollow(user)
    redirect_to user
  end
end
