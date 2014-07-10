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
		Notification.where(phone: phone, user_id: nil).each {|notif| self.notifications << notif}
	end

	def get_user_regions
		results = [[],[]]
    region_id_array = self.notifications.map { |notification| notification.region_id }
    user_regions = self.get_geoJSON
    user_regions.each do |ward|
      if ward.swept_in_date_range?(Date.today, Date.today + 7)
        results[0] << ward.my_geo
      else
        results[1] << ward.my_geo
      end
    end
    results
  end

  def get_geoJSON
  	Region.select("*, ST_AsGeoJSON(geom) as my_geo").joins(:notifications).where('notifications.user_id' => self.id)
  end
end

