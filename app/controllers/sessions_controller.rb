class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # raise user.inspect
      session[:user_id] = user.id
      redirect_to '/'
    else
      flash.now.alert = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', :notice => "Logged out!"
  end
end
