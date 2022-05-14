# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
#追記
before_action :customer_state, only: [:create]
# before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    public_mypage_path
  end

  def after_sign_out_path_for(resource)
    public_root_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退会確認
  def customer_state
   ## 入力されたemailからアカウントを特定
   @customer = Customer.find_by(email: params[:customer][:email])
   ## 取得できなければメソッド終了
   return if !@customer
   ## 取得したアカウントのパスワードと入力内容が一致しているか,またis_deletedの値はfalse[create]か
   if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
    flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
    redirect_to new_customer_registration_path
   else
     flash[:notice] = "項目を入力してください"
   end
  end
end
