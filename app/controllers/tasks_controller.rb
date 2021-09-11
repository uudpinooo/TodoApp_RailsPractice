class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
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
      flash[:notice] = "タスクの登録に失敗しました"
      render new_task_path
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
