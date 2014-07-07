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
  NotificationMailer.sign_up_notification(@user).deliver
  end




end



