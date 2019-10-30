class CreditCardsController < ApplicationController

  require "payjp"

  def new
    gon.payjp_api_key = ENV['PAYJP_ACCESS_KEY']
    gon.publickey = ENV['PAYJP_PUBLIC_KEY']
    @credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to root_path if @credit_card.exists?
  end

  def pay
    Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit_card.save
        redirect_to root_path
      else
        redirect_to action: "pay"
      end
    end
  end

  def show 
    @credit_card = CreditCard.where(user_id: current_user.id).first
    if @credit_card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    end
  end

end
