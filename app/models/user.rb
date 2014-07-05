class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
	
	has_many :notifications
	has_many :regions, through: :notifications

	has_secure_password


	#format for email should be changed, but good for now
	validates :email, uniqueness: true, :format => /.+@.+\..+/ 


	def fullname
		"#{firstname} #{lastname}"
	end
end
