class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      @user.last_signin_at = DateTime.current
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
