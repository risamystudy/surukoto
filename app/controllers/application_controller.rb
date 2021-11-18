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
  
  def counts(user)
    @count_tasks = user.tasks.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_bookmark_tasks = user.bookmark_tasks.count
  end
  
end
