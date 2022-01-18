class UsersController < ApplicationController
  def new 
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/', notice: 'Thanks for signing up!'
    else
      # If the sign up is unsuccessful reset to the sign up page
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
  
end
