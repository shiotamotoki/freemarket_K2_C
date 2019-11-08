class ItemsController < ApplicationController 
  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]
  before_action :set_item, only: [:show, :edit]

  def index
    @items = Item.limit(50)
    
  end


  def show
    @items = Item.all
    @item_images = ItemImage.all
    @other_items = Item.where( [ "id != ? and user_id = ?", params[:id], @item.user_id ] ).order("created_at DESC").limit(6)
    @same_items = Item.where( [ "id != ? and user_id != ?", params[:id], @item.user_id ] ).where(brand_id: @item.brand_id ).order("created_at DESC").limit(6)
    
  end


  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
     item.destroy
     redirect_to root_path and return
    else
    
    flash[:alert] = '削除出来ませんでした'
     redirect_to action: 'edit' 
    end
   end

  def edit
  end

  def check
    # @item = Item.find(1)
    @item = Item.find(params[:id])
  end

  def new

    @item= Item.new
    @parents = Category.where(ancestry: nil) 
    @item.item_images.build
    
  end

  def create
    # カテゴリーIDの値の設定
    category = ""      
    if item_params[:third_category_id].blank? 
      if item_params[:second_category_id].blank? 
        category = item_params[:category_id]
      else
        category = item_params[:second_category_id]
      end
    else
      category = item_params[:third_category_id]
    end

    @brand= Brand.new(
      name: item_params[:brand_id]
    )

    # ブランドIDの値の設定
    if @brand.name.blank?
      @brand.id = 1
    else
      # ID:1 は未入力
      @brand.save
    end

      # ブランドIDの値の設定
      size=""
      if item_params[:size_id].blank?
        size=0

      else
        # ID:1 は未入力
        size=item_params[:size_id]
      end

    @item = Item.new(
      name: item_params[:name],
      description: item_params[:description],
      category_id: category,
      size_id: size,
      condition_id: item_params[:condition_id],
      postage_id: item_params[:postage_id],
      prefecture_id: item_params[:prefecture_id],
      shipping_date_id: item_params[:shipping_date_id],
      price: item_params[:price],
      brand_id: @brand.id,
      user_id: current_user.id,
      status: 0
    )
   
    @item.item_images.build(
      image:item_params[:image]
    )
      
    if @item.save 
      # 商品詳細ページへ遷移 
      redirect_to @item, notice: '出品が完了しました'
    else
      redirect_to root_path, notice: '出品に失敗しました。'
    end

  end

  def win
    @items = Item.limit(50)
    
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

  def size
    @size = Size.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item).permit(
    :name, 
    :description, 
    :category_id, 
    :second_category_id,
    :third_category_id,
    :size_id, 
    :brand_id,
    :condition_id,
    :postage_id,
    :prefecture_id, 
    :shipping_date_id,
    :price,
    :image,
    [item_image_attributes: [:url]]
    ).merge(user_id: current_user.id)
  end

  
end
