class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # 複数コントローラに適用。カラムの入力データを保存許可(devise用)
   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up,keys:[:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postal_code,:address,:telephone_number])
   end
end
