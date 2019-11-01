class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(item_id: params[:item_id])
    
  end
  
  def delete
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
  end
end
