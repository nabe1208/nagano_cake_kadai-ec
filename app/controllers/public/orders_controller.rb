class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

## 5/25追記 下記(create,confirm,address_params)丸写しにつき、後ほど確認
  def create # Orderに保存する内容
   cart_items = current_customer.cart_items.all
   @order = current_customer.orders.new(order_params)
   if @order.save
     cart_items.each do |cart|
       # order_detailsにも中身を作成する操作
       order_details = OrderDdtails.new
       order_details.item_id = @order.id
       order_details.amount = cart.amount
       # 購入完了後、カート情報は削除するため、保存場所を別で用意
       order_details.price = cart_item.price
       order_details.save
     end
     redirect_to public_complete_path
     cart_items.destroy_all
   else
     @order = Order.new(order_params)
     render :new
   end
  end

  def confirm
    @order = Order.new(order_params) # 中身がない(2の処理)・・・1-3の処理
    if params[:order][:s_address] == "0" # viewのNo.が1のときの処理
     @order.name = current_customer.last_name + current_customer.first_name
     @order.address = current_customer.address
     @order.postal_code = current_customer.postal_code

    elsif params[:order][:s_address] == "1"
     @order.name = Address.find(params[:order][:address_id]).name
     @order.address = Address.find(params[:order][:address_id]).address
     @order.postal_code = Address.find(params[:order][:address_id]).postal_code

    else
     redirect_to public_confirm_path, notice: '失敗'
    end
    ## cartitemの情報確認用
    @cart_items = current_customer.cart_items.all
    ## 合計金額の処理(cart_itemモデル定義method使用)
    @subtotal = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    ## 配列オブジェクト.inject {|初期値, 要素| ブロック処理 }
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name, :customer_id)
  end

  def address_params
    params.repuire(:order).permit(:name, :address, :postal_code)
  end
end
