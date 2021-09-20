class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    user = current_user

    if @task.save
      TaskMailer.creation_email(@task, user).deliver_now
      flash[:notice] = "タスクを登録しました"
      redirect_to task_url(@task)
    else
      flash[:alert] = @task.errors.full_messages
      render new_task_path
    end
    
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update!(task_params)
    flash[:notice] = "#{@task.name}を更新しました"
    redirect_to task_path(@task)
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = "#{@task.name}を削除しました"

    # 遷移元のがindexアクションの場合はajax通信
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:action] === "index"
      head :no_content
    else
      redirect_to tasks_url
    end

  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
