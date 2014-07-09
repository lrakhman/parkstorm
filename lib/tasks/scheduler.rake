desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  Notification.sweep_notification
  puts "I worked properly."
  # If this is to indicate in production that  your job finished,
  # I'm fine with this staying here, just change the message to a
  # more informative one.
  # If not, remove it.
end

