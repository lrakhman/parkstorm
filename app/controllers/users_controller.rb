class UsersController < ApplicationController

  def show
    if current_user
      @user = User.find_by_id(params[:id])
      @user.find_user_notifications
      @regions = @user.regions.map { |region| region.to_geojson }
      redirect_to root_path unless current_user.id == params[:id].to_i
    else
      redirect_to root_path
    end
    @profile_page = true
  end
end

