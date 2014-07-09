class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
    if current_user
      redirect_to root_path unless current_user.id == params[:id].to_i
    else
      redirect_to root_path
    end
    @user = User.find_by_id(params[:id])
    @user.find_user_notifications
    @regions = @user.get_user_regions
  end

  def date_range
    @today = Date.today
    @week_from_today = Date.today + 7
  end

  def load_user_map
    @user = current_user
    render partial: 'user_map', locals: {regions: @user.get_user_regions}
  end
end

