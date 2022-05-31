class Admin::OrderDetailsController < ApplicationController
# admin_order_detail_path(patch)

 def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(order_detail_params)
    ## 入金確認になった時、製作待ち 1つでも
     if @order.status.to_s  == "payment_confirmation"
      @order.update(status: 2)
     elsif @order.status.to_s == "production"
      @order.order_details.each do |order_detail|
       if order_detail.making_status.to_s == "completion"
        @order.status = 3
       else
        @order.status = 2
        break ## each 強制終了
       end
      end
      @order.save
     end
    end
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
