class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :region

  def sent_recently?
    week_ago = Date.today - 7
    if sent_at
      sent_at >= week_ago
    else
      false
    end
  end

  def notify
  	NotificationMailer.sweep_notification(self).deliver if email 
  	TextService.send_text_message(self) if phone 
  end

	def self.sweep_notification
		Notification.all.each do |notice|
			if notice.region.swept_soon? && !notice.sent_recently?
        notice.update(sent_at: Date.today)
				notice.notify
			end
		end
	end
end

