class TaskMailer < ApplicationMailer
  def creation_email(task, user)
    @task = task
    @user = user
    mail(
      subject: 'タスクを作成しました',
      to: @user.email,
      from: @user.email,
    )
  end
end
