class NotificationsController < ApplicationController
 def create
 	logger.debug params.inspect
 	if user_signed_in?
 		logger.debug user_signed_in?
 		unless current_user.regions.include?(Region.find(session[:current_region_id]))
 			logger.debug session[:current_region_id]
 			current_user.notifications.create!(region_id: session[:current_region_id], email: current_user.email)
 		end
 	else
 		logger.debug params.inspect
 		Notification.create!(region_id: session[:current_region_id], email: params[:notification][:email])
 	end
 	logger.debug params.inspect
 		render plain: "Notification will be sent."
 end
end

