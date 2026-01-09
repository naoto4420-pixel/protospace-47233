class ApplicationController < ActionController::Base
  ##アクション前処理
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  ##プライベートメソッド
  private

  ##新規登録時に取得を許可するパラメーター追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

end
