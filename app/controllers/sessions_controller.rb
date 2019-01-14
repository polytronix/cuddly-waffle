class SessionsController < ApplicationController
  skip_before_action :check_auth
  skip_before_action :check_ip

  def new
  end

  def create
    user = User.find_by(username: params[:login][:username])
    user_password = User.find_by(password_digest: params[:login][:password])
    if user && user_password
      session[:user_id] = user.id
      redirect_to session.delete(:forward_to) || root_path
    else
      flash.now[:error] = "Invalid login"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
