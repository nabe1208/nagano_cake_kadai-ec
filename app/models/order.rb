# 注文者・配送先・送料・請求額・支払方法を1-1で格納

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {
    waiting_for_deposit: 0,  # 入金待ち
    payment_confirmation: 1, # 入金確認
    production: 2,           # 製作中
    ready_to_ship: 3,        # 発送準備中
    shipped: 4               # 発送済
  }

  validates :payment_method, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
