class UsersController < ApplicationController
  skip_before_action :login_required

  def new
  end
end
