class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to tasks_url
      flash[:notice] = "ログインしました"
    else
      flash[:alert] = ["ログインできませんでした"]
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url
    flash[:notice] = "ログアウトしました"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
