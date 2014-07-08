class NotificationsController < ApplicationController
  
  def create
    email = params[:notification][:email]
    phone = params[:notification][:phone]
   	if user_signed_in?
   		unless current_user.regions.include?(Region.find(session[:current_region_id]))
   			current_user.notifications.create!(region_id: session[:current_region_id], email: current_user.email, phone: current_user.phone)
   		end
   	else
      if Notification.where(region_id: session[:current_region_id], email: email, phone: phone).empty?
   		  Notification.create!(region_id: session[:current_region_id], email: email, phone: phone)
   	  end
    end
 		render plain: "Notification will be sent."
  end

  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    render plain: "Success"
  end
end


   