class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]

  def index
    @items = Item.all.limit(10)
  end

  def show
    @items = Item.all
    @users = User.all
    @item_images = ItemImage.all
    @user_evaluations = UserEvaluation.all
    @brands = Brand.all
    @categories = Category.all
    @personal_informations = PersonalInformation.all
  end

  def new

    @item= Item.new
    @parents = Category.where(ancestry: nil) 
    @item.item_images.build
    
  end

  def create

    @brand= Brand.new(
      name: item_params[:brand_id]
    )

    # ブランドIDの値の設定
    if @brand.name == ""
      # ID:1 は未入力
      @brand.id = 1
    else
      @brand.save
    end

    # カテゴリーIDの値の設定
    category = ""      
    if item_params[:third_category_id] == "" 
      if item_params[:second_category_id] == "" 
        category = item_params[:category_id]
      else
        category = item_params[:second_category_id]
      end
    else
      category = item_params[:third_category_id]
    end


    @item = Item.new(
      name: item_params[:name],
      description: item_params[:description],
      category_id: category,
      size_id: item_params[:size_id],
      condition_id: item_params[:condition_id],
      postage_id: item_params[:postage_id],
      prefecture_id: item_params[:prefecture_id],
      shipping_date_id: item_params[:shipping_date_id],
      price: item_params[:price],
      status_id: item_params[:status],
      brand_id: @brand.id,
      user_id: current_user.id,
      status_id: 0
    )
   
    @item.item_images.build(
      # 画像は一旦埋め込み 
      image:"https://static.mercdn.net/thumb/photos/m39106015049_1.jpg?1558957377"
    )
    if @item.save 
      # 商品詳細ページへ遷移 
      redirect_to @item, notice: '出品が完了しました'
    else
      redirect_to root_path, notice: '出品に失敗しました。'
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

  def size
    @shoessize = Shoessize.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

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
    :images_attributes: [:image]
    ).merge(user_id: current_user.id)
  end
  
  def new_image_params
    params.require[:image].permit(:image)
  end
end
