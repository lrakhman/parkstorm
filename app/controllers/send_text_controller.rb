class SendTextController < ApplicationController
	def index
  end
 
  def send_text_message
    number_to_send_to = params[:notification][:phone]
 
    twilio_sid = ENV["twilio_sid"]
    twilio_token = ENV["twilio_token"]
    twilio_phone_number = ENV["twilio_phone_number"]
 
    @twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)
 
    if user_signed_in?
      unless current_user.regions.include?(Region.find(session[:current_region_id]))
        current_user.notifications.create!(region_id: session[:current_region_id], phone: current_user.phone)
      end
    else
      if Notification.where(region_id: session[:current_region_id], phone: phone).empty?
        Notification.create!(region_id: session[:current_region_id], phone: phone)
      end
    end

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "There will be street cleaning in your ward soon. Please move your car. "
    )
  end
end

