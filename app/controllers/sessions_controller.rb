class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'You successfully logged in.'
      redirect_to @user
    else
      flash.now[:danger] = 'Your email or password is incorrect.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'See you soon.'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # succced to login
      session[:user_id] = @user.id
      return true
    else
      #Failed to login
      return false
    end
  end
end
