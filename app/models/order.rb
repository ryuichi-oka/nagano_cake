class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true



  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting: 0, confirm: 1, product: 2, ready: 3, sent: 4}


end
