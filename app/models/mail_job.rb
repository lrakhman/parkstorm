class MailJob 

	def perform
		Notification.sweep_notification
	end

	
end