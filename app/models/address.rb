class Address < ApplicationRecord
  belongs_to :customer

# options_from_collection_fo_select(ヘルパーメソッド)表示部分を定義
  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
