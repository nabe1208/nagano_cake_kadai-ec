class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
    # 指定モデル商品作成日から最新の4件
    @items = Item.order(created_at: :desc).limit(4)
  end
end
