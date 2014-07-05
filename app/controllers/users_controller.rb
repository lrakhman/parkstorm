class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

end
