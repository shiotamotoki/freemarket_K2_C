class ItemsController < ApplicationController 
  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]
  before_action :set_item, only: [:show, :edit]
  before_action :set_search
  before_action :move_to_sign_up, except: [:index, :show,:child_category,:grandchild_category]

  def index
    @items = Item.limit(50)
    @category_lady = Item.where(category_id: 1..199)
    @category_man = Item.where(category_id: 200..344)
    @category_electrical_appliances = Item.where(category_id: 893..978)
    @category_toy = Item.where(category_id: 680..792)

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
     flash[:alert] = '商品を削除しました'
     redirect_to mypages_path
    else
    
    flash[:alert] = '削除出来ませんでした'
    redirect_to action: 'edit' 
    end
  end

  def edit
  end

  def check
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
      shipping_method_id: item_params[:shipping_method_id],
      price: item_params[:price],
      brand_id: @brand.id,
      user_id: current_user.id,
      status: 0
    )

    # @item.item_images.build(
    #   image:item_params[:image]
    # )

    if @item.save
      # 商品詳細ページへ遷移 
      params[:image]['image'].each do |image|
        @item.item_images.create(image: image, item_id: @item.id)
      end
      
      redirect_to @item, notice: '出品が完了しました'
    else
      redirect_to root_path, notice: '出品に失敗しました。'
    end

  end

  def brand
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

  def search
    @search_words = params[:q][:name_or_description_cont] unless !params[:q].present? || @search_words.present?
    @words = params[:q].delete(:name_or_description_cont) if params[:q].present?
    if @words.present?
      params[:q][:groupings] = []
      @words.split(/[ 　]/).each_with_index do |word, i| #全角空白と半角空白で切って、単語ごとに処理します
        params[:q][:groupings][i] = { name_or_description_cont: word }
      end
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
    :shipping_method_id,
    :price,
    :image,
    [image: [:image]]
    ).merge(user_id: current_user.id)
  end
  
  def search_params
    params.require(:q).permit(:name_and_description_cont_any)
  end

  def set_search
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def move_to_sign_up
    redirect_to new_user_session_path unless user_signed_in?
  end
end
