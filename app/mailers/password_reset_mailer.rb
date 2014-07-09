class PasswordResetMailer < Devise::Mailer
  def reset_password_instructions(record)
    mandrill = Mandrill::API.new("#{MandrillConfig.api_key}")
    mandrill.messages 'send-template',
            { 
              :template_name => 'reset-password-notification', 
              :template_content => "",
              :message => {
                :subject => "Forgot Password",
                :from_email => "4c&ad4lyfe@gmail.com",
                :from_name => "Don't Park There! CHI",
                :to => [
                  {
                    :email => user.email
                  }
                ],
                :global_merge_vars => [
                  {
                    :name => "FIRST_NAME",
                    :content => user.first_name
                  },
                  {
                    :name => "FORGOT_PASSWORD_URL",
                    :content => "<a href='#{edit_user_password_url(:reset_password_token => user.reset_password_token)}'>Change My Password</a>"
                  }
                ]
              }
            }
      #We need to call super because Devise doesn't think we have sent any mail 
      super
  end
end
