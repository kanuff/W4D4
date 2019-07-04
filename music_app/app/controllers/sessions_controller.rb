class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to user_url(current_user)
      return
    end
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user
      login_user!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["No that was wrong"]
      render :new
    end
  end

  def destroy
    unless logged_in?
      redirect_to new_user_url
      return
    end
    logout!
    redirect_to new_session_url
  end

end