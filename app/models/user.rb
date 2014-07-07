class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         	
	has_many :notifications
	has_many :regions, through: :notifications

	#format for email should be changed, but good for now
	validates :email, uniqueness: true, :format => /.+@.+\..+/ 


	def fullname
		"#{firstname} #{lastname}"
	end

	def find_user_notifications
		Notification.where(email: email, user_id: nil).each {|notif| self.notifications << notif}
	end

	def send_reminders
		regions = self.regions.select {|x| x.swept_soon? }.map(&:ward_secti)
		
		if regions.any?
			User.all.email.each {|x| x.send_email}
		end
	end

	def add_regions
		self.regions << session[:current_region]
	end

	

end

