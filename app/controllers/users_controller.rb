class UsersController < ApplicationController

  def index
    @users = User.all
    @regions = Region.all.pluck(:ward_secti)
  end
end
