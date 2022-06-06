# 編集中
class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: @order.id)
    ## 入金確認(status変更)したら着手不可から製作待ち(making_status変更)へ
    ## 1つでも製作中(making_status変更)になったら、製作中(status)
    ## 1つでも製作完了(making_status)になったら、発送準備中(status)
    @order.update(order_params)
    @order_detail.update_all(making_status: 1) if  @order.status == 'payment_confirmation'
    redirect_to admin_order_path(@order.id), notice: 'ステータスを更新しました'
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
