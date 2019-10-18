class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:sell, :create, :edit, :update, :destroy, :buy]

  def index
    @items = Item.all.limit(10)
  end

  def show
    @items = Item.all.limit(10)
    @users = User.all
  end
end
