class PurchaseController < ApplicationController

  require 'payjp'

  def index
    credit_card = CreditCards.where(user_id: current_user.id).first
    if credit_card.blank?
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      customer = Payjp::Customer.retrieve(credit_card.customer_id)
      @default_card_information = customer.credit_cards.retrieve(credit_card.card_id)
    end
  end

  def pay
    @item=Item.find(params[:id])
    credit_card = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
    Payjp::Charge.create(
    :amount => @item.price, 
    :customer => credit_card.customer_id, 
    :currency => 'jpy', 
    )
    @item.status = 3
    @item.save
    redirect_to action: 'done', id: @item.id 
  end

  def done
    @item = Item.find(params[:id])
  end
end
