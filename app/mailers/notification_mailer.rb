class NotificationMailer < ActionMailer::Base
  default from: "lana.rakhman@gmail.com"

  def sign_up_notification(user)

      @user = user

      mail(:to => @user.email,
             :name => @user.name,
             :subject => "Thanks for Signing Up")
             # :unsub_link => unsub_email_link("123"))   
  end

  def order_notification(user)

      @user = user

      mail(:to => @user.email)
  end
end
