class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
  end
  def create
    @cart_item = new(cart_item_params)
    @cart_item.save
    redirect_to public_cart_items_path
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end

