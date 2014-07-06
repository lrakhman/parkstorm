class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         	
	has_many :notifications
	has_many :regions, through: :notifications

	#format for email should be changed, but good for now
	validates :email, uniqueness: true, :format => /.+@.+\..+/ 


	def fullname
		"#{firstname} #{lastname}"
	end

	def send_reminders
		regions = self.regions.select {|x| x.swept_soon? }.map(&:ward_secti)
		# regions.map(&:to_i)
		if regions.any?
			User.all.email.each {|x| x.send_email}
		end
	end

	def add_regions
		self.regions << session[:current_region]
	end

	

end

