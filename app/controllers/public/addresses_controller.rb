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
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
     redirect_to public_addresses_path, notice: '正常に更新されました'
    else
     redirect_to edit_public_address_path(@address.id), notice: '更新に失敗しました'
    end
  end

  def destroy
    @addresses = Address.where(customer_id: current_customer.id)
    @addresses.destroy
    redirect_to public_addresses_path, notice: '削除しました'
  end

  private
  def address_params
   params.require(:address).permit(:postal_code,:address,:name)
  end

end
