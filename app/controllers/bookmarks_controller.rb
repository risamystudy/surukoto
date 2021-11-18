class BookmarksController < ApplicationController
  #before_action  :require_user_logged_in
  
  def create
    task = Task.find(params[:task_id])
    current_user.bookmark(task)
    flash[:success] = 'タスクをブックマークしました'
    redirect_to request.referer
  end

  def destroy
    task = Task.find(params[:task_id])
    current_user.unbookmark(task)
    flash[:success] = 'ブックマークを解除しました'
    redirect_to request.referer
  end
  
end
