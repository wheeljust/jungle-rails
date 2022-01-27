class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate_with_credentials(params[:session][:email], params[:session][:password])
      # Save the user id in cookie.
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:new, :session]
  end
  
end
