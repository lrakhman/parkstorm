class UsersController < ApplicationController

 def create
    super
    NotificationMailer.sign_up_notification(@user).deliver
 end

 

end

    # @regions = Region.all.pluck(:ward_secti)
