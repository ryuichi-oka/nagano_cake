class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_detales

  enum payment_method: {credit_card: 0, transfer: 1 }
  enum status: {waiting: 0, confirm: 1, product: 2, ready: 3, sent: 4}

end
