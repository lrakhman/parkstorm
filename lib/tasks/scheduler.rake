desc "This task is called by the Heroku scheduler add-on"
task :send_reminders => :environment do
  puts "I work properly"
end

task :print => :environment do
	puts "I work too."
end

