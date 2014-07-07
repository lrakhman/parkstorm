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

	def self.sweep_notification
		Notification.all.each do |notice|
			if notice.region.swept_soon? && !notice.sent_recently?
        notice.update(sent_at: Date.today)
				NotificationMailer.sweep_notification(notice).deliver
			end
		end
	end
end

