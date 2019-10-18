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
    binding.pry
  end
end
