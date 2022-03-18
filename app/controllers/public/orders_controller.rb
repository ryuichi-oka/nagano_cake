class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    # 注文を作成
    @order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items.all
    # カート内商品を取得し商品合計を計算する（小計を足していく）
    @order.save
    cart_items.each do |cart_item|
    # 注文詳細を作成
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.with_tax_price
      order_detail.save
    end
    # 現在注文中の会員のカート内商品をすべて削除
    cart_items.destroy_all
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
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      render :new
    end
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.subtotal}
    @order.shipping_cost = "800"
    @order.total_payment = @order.shipping_cost + @total_price
  end

  def index
    @orders = current_customer.orders.all

  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
    @total_price = @order_details.sum{|order_detail|order_detail.subtotal}
    @order.shipping_cost = "800"
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
