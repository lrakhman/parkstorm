class UsersController < ApplicationController
	has_many :notifications
	has_many :regions, through: :notifications

	has_secure_password
end
