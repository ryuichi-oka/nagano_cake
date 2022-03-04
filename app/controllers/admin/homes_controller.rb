class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    @order_total = OrderDetail.sum(:amount)
  end
end
