class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  
  private
  
  #ログイン要求(ここで定義して継承コントローラーで使う)
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
