class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.where(customer_id: current_customer.id)
    @address = Address.new
  end

  def create
   @address = current_customer.addresses.new(address_params)
   if @address.save
     redirect_to public_addresses_path, notice: "新しいお届け先を保存しました"
   else
     redirect_to public_addresses_path, notice: "入力内容が正しくありません"
   end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def address_params
   params.require(:address).permit(:postal_code,:address,:name)
  end

end
