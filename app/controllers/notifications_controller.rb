class NotificationsController < ApplicationController
  def create
    email = params[:notification][:email]
   	if user_signed_in?
   		unless current_user.regions.include?(Region.find(session[:current_region_id]))
   			current_user.notifications.create!(region_id: session[:current_region_id], email: current_user.email)
   		end
   	else
      if Notification.where(region_id: session[:current_region_id], email: email).empty?
   		  Notification.create!(region_id: session[:current_region_id], email: email)
   	  end
    end
 		render plain: "Notification will be sent."
  end
end

