class UsersController < ApplicationController
	before_action :authenticate_user!
	
  def index
    @users = User.all
    @regions = Region.all.pluck(:ward_secti)
  end
end
