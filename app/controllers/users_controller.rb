class UsersController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.new(user_params)
    user.save!
    flash[:notice] = "ユーザー#{user.name}を登録しました。ログインしてください。"
    redirect_to login_url
  end

  private

  def user_params
    params.require(:new_user).permit(:name, :email, :password)
  end
end
