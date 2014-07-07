namespace :db  do
  desc "import regions db after migrate"
  task :after_migrate => :environment do
    system('psql -d parkstorm_development -c "CREATE EXTENSION postgis";')
    system('psql -d parkstorm_development < db/fixtures/the_business.sql')
  end

  desc "import regions db after test db:test:prepare"
  task :test_after_prepare => :environment do
    system('psql -d parkstorm_test -c "CREATE EXTENSION postgis";')
    system('psql -d parkstorm_test < db/fixtures/the_business.sql')
  end

  desc "import regions db after test db migrate"
  task :travis_after_migrate => :environment do
    # system('psql -d travis_ci_test -c "CREATE EXTENSION postgis";')
    system('psql -d travis_ci_test < db/fixtures/the_business.sql')
  end
end

# desc "send email reminders to move car"
# task :send_reminders => :environment do
#   if (next_cleaning_day == Date.today + 7) || (next_cleaning_day == Date.today + 1)
#     User.send_reminders
#   end
# end

