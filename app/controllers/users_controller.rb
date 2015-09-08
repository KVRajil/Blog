class UsersController < ApplicationController
  def new
    if !current_user
      @user = User.new
    else
      redirect_to articles_path
    end
  end

  def create
    if !current_user
      @user = User.new(user_params)
      if @user.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render "new"
      end

    else
      redirect_to articles_path
    end
    end

  def user_params
    params.require(:user).permit(:username,:email, :password, :password_confirmation)
  end
end
