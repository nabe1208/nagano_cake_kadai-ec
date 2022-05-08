class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum making_status: { cannot_be_manufactured: 0, waiting_for_production: 1, manufacturing: 2, completion: 3 }
end
