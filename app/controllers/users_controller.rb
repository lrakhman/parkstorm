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

end

    # @regions = Region.all.pluck(:ward_secti)
