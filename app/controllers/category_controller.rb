class CategoryController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
  end
  



  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end



  def child_category
    @children = Category.where(ancestry: params[:parent_id])
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def grandchild_category
    @grandchildren = Category.where(ancestry: "#{params[:parent_id]}/#{params[:child_id]}")
    respond_to do |format|
      format.html
      format.json
    end
  end
end
