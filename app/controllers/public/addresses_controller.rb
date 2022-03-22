class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def new
  end

  def index
    @addresses = current_customer.addresses.all
    @address = current_customer.addresses.new
  end

  def create
    @addresses = current_customer.addresses.all
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = current_customer.addresses.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end
end
