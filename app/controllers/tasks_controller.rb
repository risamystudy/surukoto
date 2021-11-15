class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @user = current_user
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました'
      redirect_to user_url(@user)
    else
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'users/show'
    end
  end

  def edit
  end

  def update
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
