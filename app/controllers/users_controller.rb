class UsersController < ApplicationController
  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    super
    NotificationMailer.sign_up_notification(@user).deliver
  end

  def show
    @user = User.find_by_id(params[:id])
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

    # @regions = Region.all.pluck(:ward_secti)
