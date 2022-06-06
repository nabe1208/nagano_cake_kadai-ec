class Public::CustomersController < ApplicationController
  # mypage
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_mypage_path, notice: "更新されました"
    else
      render :edit
    end
  end

  # 退会確認ページ
  def followings
  end

  def withdrawal
    @customer = current_customer
    # is_deletedカラムをtrueに変更→削除フラグ
    @customer.update(is_deleted: true)
    reset_session
    #flash[:notice] = "退会処理を実行致しました"
    redirect_to public_root_path, notice: "退会処理を実行致しました"
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name,:last_name_kana,:first_name,:first_name_kana,:postal_code,:address,:telephone_number,:email)
  end

end
