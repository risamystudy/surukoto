class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    redirect_to user_path(current_user)
  end
  
  
  def create
    @user = current_user
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクの投稿に成功しました'
      redirect_to user_url(@user)
    else
      @pagy, @tasks = pagy(@user.feed_tasks.order(id: :desc))
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'users/show'
    end
    
  end

  def edit
    @user = current_user
    @task = Task.find(params[:id])
  end

  def update
    @user = current_user
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to user_url(@user)
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success]= 'タスクを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content)
  end
  
  #ログインユーザーの投稿か確認する
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
