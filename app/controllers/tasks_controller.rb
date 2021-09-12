class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = "タスクを登録しました"
      redirect_to task_url(@task)
    else
      flash[:alert] = "タスクの登録に失敗しました"
      render new_task_path
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "#{@task.name}を削除しました"
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
