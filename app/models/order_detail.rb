class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum maiking_status: {cannot: 0, waiting: 1, product: 2, complete: 3}

end
