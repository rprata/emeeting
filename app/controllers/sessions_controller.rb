class SessionsController < ApplicationController

  def new
    if session[:user_id]
      redirect_to '/events'
    end
  end

  def create
      @user = User.find_by_email(params[:session][:email])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
        redirect_to '/events'
      else
        redirect_to '/login'
        flash[:error] = "E-mail and senha inválidos. Por favor, tente novamente."
      end 
  end

  def destroy 
      session[:user_id] = nil 
      redirect_to '/login' 
  end

end

