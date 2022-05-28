class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

## 5/25追記 下記(create,confirm,address_params)丸写しにつき、後ほど確認
  def create # Orderに保存する内容
   @order = Order.new(order_params)
   cart_item = current_customer.cart_items.all
   @order.save
     current_customer.cart_items.each do |cart_item|
       # order_detailsにも中身を作成する操作
       order_detail = OrderDetail.new
       order_detail.order_id = @order.id
       order_detail.item_id = cart_item.item_id
       order_detail.amount = cart_item.amount
       # 購入完了後、カート情報は削除するため、保存場所を別で用意
       order_detail.price = cart_item.item.price
       order_detail.making_status = "cannot_be_manufactured"
       order_detail.save
     end
     cart_item.destroy_all
     redirect_to public_complete_path
  end

  def confirm
    @order = Order.new(order_params) # ←2の処理、それ以外が0-1の下記の処理
    if params[:order][:s_address] == "0" # 0のときの処理
     @order.name = current_customer.last_name + current_customer.first_name
     @order.address = current_customer.address
     @order.postal_code = current_customer.postal_code

    elsif params[:order][:s_address] == "1"
     @order.name = Address.find(params[:order][:address_id]).name
     @order.address = Address.find(params[:order][:address_id]).address
     @order.postal_code = Address.find(params[:order][:address_id]).postal_code
    end
    ## cartitemの情報確認用
    @cart_items = current_customer.cart_items.all
    ## 合計金額の処理(cart_itemモデル定義method使用)
    @subtotal = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    ## 配列オブジェクト.inject {|初期値, 要素| ブロック処理 }
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    #binding.pry
  end

  private
  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id, :total_payment, :postage, :status)
  end

  def address_params
    params.repuire(:order).permit(:name, :address, :postal_code)
  end
end
