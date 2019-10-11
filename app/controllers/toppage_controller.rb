class ToppageController < ApplicationController
  def index
    @items = Item.all.limit(10)
  end
end
