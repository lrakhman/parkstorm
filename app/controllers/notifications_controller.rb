class NotificationsController < ApplicationController
 def create
 	logger.info params.inspect
 	if user_signed_in?
 		logger.info user_signed_in?
 		unless current_user.regions.include?(Region.find(session[:current_region_id]))
 			logger.info session[:current_region_id]
 			current_user.notifications.create!(region_id: session[:current_region_id], email: current_user.email)
 		end
 	else
 		logger.info params.inspect
 		Notification.create!(region_id: session[:current_region_id], email: params[:notification][:email])
 	end
 	logger.info params.inspect
 		render plain: "Notification will be sent."
 end
end

