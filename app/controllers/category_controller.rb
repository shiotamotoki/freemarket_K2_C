class CategoryController < ApplicationController

  def index
    
  end
  
  def show
    @items = Item.all
    @category_id = params[:id]
    @categories = Category.find(params[:id])



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
