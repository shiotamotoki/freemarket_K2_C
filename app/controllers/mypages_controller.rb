class MypagesController < ApplicationController
  before_action :set_item, only: [:item, :stop, :start]
  def index
  end

  def edit  
  end
  
  def item
 
  end

  def stop
    @item.status = 2
    if @item.save
      flash[:alert] = '出品の一時停止をしました。'
    else
      flash[:alert] = '出品の一時停止に失敗しました。'
    end
    redirect_to item_mypage_path(@item.id)
  end

  def start
    @item.status = 0
    if @item.save
      flash[:alert] = '出品を再開しました。'
    else
      flash[:alert] = '出品の再開に失敗しました。'
    end
    redirect_to item_mypage_path(@item.id)
  end

  def myitem
    @item = current_user.items
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
