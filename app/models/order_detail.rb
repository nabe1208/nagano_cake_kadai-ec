# 注文商品・数量・購入時価格を1-1で

class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: {
    cannot_be_manufactured: 0, # 製造不可
    waiting_for_production: 1, # 製造待ち
    manufacturing: 2,          # 製造中
    completion: 3              # 製造完了
  }

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end

end
