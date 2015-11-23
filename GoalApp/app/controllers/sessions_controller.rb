class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(username, password)
    return if user.nil?
    sign_in(user)
    redirect_to users_url
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end

  private
  def username
    params[:user][:username]
  end

  def password
    params[:user][:password]
  end
end
