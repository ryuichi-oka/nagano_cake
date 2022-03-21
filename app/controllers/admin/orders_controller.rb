class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.shipping_cost = "800"
    @total_price = @order_details.sum{|order_detail|order_detail.subtotal}
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :total_payment, :payment_method, :status)
  end

end
