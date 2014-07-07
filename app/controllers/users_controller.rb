class UsersController < ApplicationController
 
  def index
    @users = User.all
  end

  def new
  end

  def create
  NotificationMailer.sign_up_notification(@user).deliver
  end

  def show
    @user = User.find_by_id(params[:id])
    @user.find_user_notifications
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    flash.notice = "Account Updated!"

    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :email)
  end

end



