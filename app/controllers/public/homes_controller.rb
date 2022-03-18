class Public::HomesController < ApplicationController
  def top
    @items = Item.order("created_at DESC").limit(4).where(is_active: true)
    @genres = Genre.all
  end
end
