class TaskMailer < ApplicationMailer
  def create_task(task, user)
    @task = task
    @user = user
    mail(
      subject: 'タスクを作成しました',
      to: @user.email,
    )
  end

  def edit_task(task, user)
    @task = task
    @user = user
    mail(
      subject: 'タスクを編集しました',
      to: @user.email,
    )
  end

  def destroy_task(task, user)
    @task = task
    @user = user
    mail(
      subject: 'タスクを削除しました',
      to: @user.email,
    )
  end
end
