class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]

  def index
    @items = Item.all.limit(10)
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
    @users = User.all
    @item_images = ItemImage.all
    @user_evaluations = UserEvaluation.all
    @brands = Brand.all
    @categories = Category.all
    @personal_informations = PersonalInformation.all
    @brands = Brand.all
    @shipping_date = ShippingDate.all
    @other_items = Item.where( [ "id != ? and user_id = ?", params[:id], @item.user_id ] ).order("created_at DESC").limit(6)
    @same_items = Item.where( [ "id != ? and user_id != ?", params[:id], @item.user_id ] ).where(brand_id: @item.brand_id ).order("created_at DESC").limit(6)
  end

  def check
    @item = Item.find(1)
  end
end
