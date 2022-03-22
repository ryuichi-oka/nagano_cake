class Address < ApplicationRecord

  belongs_to :customer, optional: true

  validates :postal_code, presence: { message: 'は必須です' }
  validates :address, presence: { message: 'は必須です' }
  validates :name, presence: { message: 'は必須です' }


  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
