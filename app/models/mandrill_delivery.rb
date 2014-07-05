class MandrillDelivery
  attr_accessor :message

  def initialize(mail)
  end

  def deliver!(mail)
    build_meta_mandrill(mail)
    send_mandrill(mail)
  end

#Message stuff

  def build_meta_mandrill(mail)

    #build Mandrill message hash
    @message = {
      :from_name=> "Admin",
      :from_email=>"admin@somewhere.com",
      :subject=> "#{mail['subject']}",
      :to=>[
            {
              :email=> "#{mail['to']}",
              :name=> "#{mail['name']}"
            }
           ],
      :auto_text => true,
      :global_merge_vars => [
                             {
                               :name => "LISTCOMPANY",
                               :content => "Company Name Here"
                             }
                            ]
    }

    true
  end

  #sends email via Mandrill
  def send_mandrill(mail)
    m = Mandrill::API.new

    sending = m.messages.send_template('Sign-Up Confirmation',
                                       [
                            {
                              :name => 'main',
                              :content => "#{mail.body}"
                            },
                            {
                              :name => 'unsub',
                              :content => "#{mail['unsub_link']}"
                            }
                           ],
                           message = @message)
    Rails.logger.info sending
  end

end
