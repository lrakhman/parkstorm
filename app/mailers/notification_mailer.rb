class NotificationMailer < ActionMailer::Base
  default from: "lana.rakhman@gmail.com"

  def sign_up_notification(user)

      @user = user

      mail(:to => @user.email,
             :name => @user.name,
             :subject => "Thanks for Signing Up")
             # :unsub_link => unsub_email_link("123"))   
  end

  def sweep_notification(user)
      @user = user
      mail(:to => user.email,
             # :ward => notice.region.ward,
             # :area => notice.region.sweep,
             :subject => "Sweeping Notification for Ward #{notice.region.ward_num}")
  end

end
