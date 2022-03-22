class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :addresses
  has_many :cart_items

  validates :last_name, presence: { message: 'は必須です' }
  validates :first_name, presence: { message: 'は必須です' }
  validates :last_name_kana, presence: { message: 'は必須です' }
  validates :first_name_kana, presence: { message: 'は必須です' }
  validates :postal_code, presence: { message: 'は必須です' }
  validates :address, presence: { message: 'は必須です' }
  validates :telephone_number, presence: { message: 'は必須です' }


end
