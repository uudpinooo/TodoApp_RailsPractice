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

    if @task.save
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
    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
