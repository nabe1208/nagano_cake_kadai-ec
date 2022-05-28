# 注文商品・数量・購入時価格を1-1で

class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum making_status: { cannot_be_manufactured: 0, waiting_for_production: 1, manufacturing: 2, completion: 3 }
end
