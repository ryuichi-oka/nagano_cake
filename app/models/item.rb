class Item < ApplicationRecord

##ActiveStorage
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default_image.ipg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit:[width, height]).processed
  end

  has_many :order_details
  belongs_to :genre

##消費税を求めるメソッド
  def with_tax_price
    (price * 1.1).floor
  end

end
