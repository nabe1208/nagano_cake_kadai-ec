class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # validates :is_active, presence: true

  # 消費税を求めるメソッド
  # CartItemモデルの小計メソッドと併用
  def with_tax_price
    (price * 1.1).floor
  end

end
