class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :region

	def self.sweep_notification
		Notification.all.each do |notice|
			if notice.region.swept_soon?
				NotificationMailer.sweep_notification(notice).deliver!
			end
		end
	end
end

