class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

# options_from_collection_fo_select(ヘルパーメソッド)表示部分を定義
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
