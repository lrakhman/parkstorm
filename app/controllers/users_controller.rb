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
    @user = User.new(params[:id])
    @user.regions << session[:current_region]
  end

end

        # NotificationMailer.sign_up_notification(@user).deliver


