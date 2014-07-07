desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  Notification.sweep_notification
end

task :print => :environment do
	puts "I work too."
end

