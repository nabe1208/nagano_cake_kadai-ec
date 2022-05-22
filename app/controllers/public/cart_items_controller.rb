class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    ## 同名あり
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      # カート内：item_id、 newで追加したもの：params[:cart_item][:item_id]
       cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
      # さらにidを特定して、cart_item.quantityに追加したparamsを数字として(.to_i)加える。
       cart_item.save
       redirect_to public_cart_items_path
    ## 同名なし
    elsif @cart_item.save
          @cart_items = current_customer.cart_items
          render "index"
    ## 保存不可
    else
       redirect_to public_cart_items_path, notice: "カートに商品を追加できませんでした"
    end

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end

