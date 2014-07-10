require 'rails_helper'

RSpec.describe Notification, :type => :model do
	describe '#sent_recently?' do
    it 'should return false when not sent' do
      notification = Notification.create(email: 'pdebelak@example.com', region_id: 1)
      expect(notification.sent_recently?).to be false
    end

    it 'should return false if sent more than a week ago' do
      notification = Notification.create(email: 'pdebelak@example.com', region_id: 1, sent_at: Date.today - 8)
      expect(notification.sent_recently?).to be false
    end

    it 'should return true if sent within the past week' do
      notification = Notification.create(email: 'pdebelak@example.com', region_id: 1, sent_at: Date.today - 6)
      expect(notification.sent_recently?).to be true
    end
  end
end
