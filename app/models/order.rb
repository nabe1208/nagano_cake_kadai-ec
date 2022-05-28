# 注文者・配送先・送料・請求額・支払方法を1-1で格納

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_for_deposit: 0, payment_confirmation: 1, producrion: 2, ready_to_ship: 3, shipped: 4 }

end
