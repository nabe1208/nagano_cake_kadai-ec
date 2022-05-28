# 編集中
class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id), notice: 'ステータスを更新しました'
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :making_status)
  end

end
