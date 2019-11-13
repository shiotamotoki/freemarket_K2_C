class CategoryController < ApplicationController

  def index
    
  end
  
  def show
    @items = Item.all
    @category_id = params[:id]
    @categories = Category.find(params[:id])
    @paramsid = params[:id].to_i
   
   
    
    if @paramsid == @parents[0].id
      @category_name = Item.where(category_id: 1..199)
    elsif @paramsid == @parents[1].id
      @category_name = Item.where(category_id: 200..344)
    elsif @paramsid == @parents[2].id
      @category_name = Item.where(category_id: 345..479)
    elsif @paramsid == @parents[3].id
      @category_name = Item.where(category_id: 480..621)
    elsif @paramsid == @parents[4].id
      @category_name = Item.where(category_id: 622..679)
    elsif @paramsid == @parents[5].id
      @category_name = Item.where(category_id: 680..792)
    elsif @paramsid == @parents[6].id
      @category_name = Item.where(category_id: 793..892)
    elsif @paramsid == @parents[7].id
      @category_name = Item.where(category_id: 893..978)
    elsif @paramsid == @parents[8].id
      @category_name = Item.where(category_id: 979..1000)
    elsif true == @categories.ancestry.include?("/")
      @category_name = Item.where(category_id: @paramsid )
    elsif false == @categories.ancestry.include?("/")
      @category_name = Item.where(category_id: @paramsid )
    else
      @category_name = Item.all
    end
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
