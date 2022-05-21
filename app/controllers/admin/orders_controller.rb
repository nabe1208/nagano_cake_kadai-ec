# 編集中
class Admin::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  # 投稿確認-createへ送る(post)-内容が不適切ならnewへ戻る
  def confirm
    @order = Order.new(order_params)
    render :new if @order.invalid? # 無効の場合は何処へ？
  end

  def create
    @order = Order.new(order_params)
  end

  def complete
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :address)
  end

end
