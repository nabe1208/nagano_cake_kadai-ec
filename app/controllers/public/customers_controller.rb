class Public::CustomersController < ApplicationController
  # mypage
  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
  end

  # 退会ページ
  def followings
#    @customer = Customer.find_by(params[:])
  end

  def withdrawal
    @customer = current_customer
    # is_deletedカラムをtrueに変更→削除フラグ
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行致しました"
    redirect_to public_root_path
  end

end
