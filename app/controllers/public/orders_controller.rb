class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    # 注文を作成
    @order = Order.new(order_params)
    # カート内商品を取得し商品合計を計算する（小計を足していく）
    @order.save

    # 注文詳細を作成
    # ...

    # 現在注文中の会員のカート内商品をすべて削除
    redirect_to thanks_path
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.save
    else
      render :new
    end
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.subtotal}
    @order.shipping_cost = "800"
    @order.total_payment = @order.shipping_cost + @total_price
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
end
