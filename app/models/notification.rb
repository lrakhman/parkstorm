class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :region

	def send_email
		Notification.select {|x| x.region.swept_soon?}
	end

	


end

