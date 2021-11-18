class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 5)
  end

  def show
    @user = User.find(params[:id])
#    if @user == current_user
#   @pagy, @tasks = pagy(@user.feed_tasks.order(id: :desc))      
# else
   @pagy, @tasks = pagy(@user.tasks.order(id: :desc))
# end
    counts(@user)
    
    if logged_in?
      @task = current_user.tasks.build
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
