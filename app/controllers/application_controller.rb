class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
  private 
    def after_sign_in_path_for(resource)
      top_path # ログイン後に遷移するpathを設定
    end

    def after_sign_out_path_for(resource)
      root_path # ログアウト後に遷移するpathを設定
    end
  
end