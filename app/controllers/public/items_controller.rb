class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
    else
      @items = Item.where(is_active: true).page(params[:page]).per(8)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all

  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end
