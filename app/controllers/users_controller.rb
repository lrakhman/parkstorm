class UsersController < ApplicationController
  # prepend_before_filter :verify_user, only: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def new
  end

  # POST /users
  # POST /users.json
  def create
  
  end

  private
  
  def verify_user
    ## redirect to appropriate path
    redirect_to new_user_path
  end

end

        # NotificationMailer.sign_up_notification(@user).deliver


