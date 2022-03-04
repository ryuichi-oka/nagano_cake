module Admin::ItemsHelper

##価格に桁区切りと"円"を追加する
  def number_to_currency(price)
    "#{price.to_s(:delimited, delimiter: ',')}"
  end

end
