class NotificationsController < ApplicationController
  def create
   	if user_signed_in?
   		unless current_user.regions.include?(Region.find(session[:current_region_id]))
   			current_user.notifications.create!(region_id: session[:current_region_id], email: current_user.email)
   		end
   	else
   		Notification.create!(region_id: session[:current_region_id], email: params[:notification][:email])
   	end
 		render plain: "Notification will be sent."
  end
end

