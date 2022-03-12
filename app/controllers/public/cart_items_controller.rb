class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @total_price = @cart_items.sum{|cart_item|cart_item.subtotal}
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
