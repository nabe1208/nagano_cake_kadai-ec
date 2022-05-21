class Admin::HomesController < ApplicationController

  def top
    @order_details = Order.all
  end
end
