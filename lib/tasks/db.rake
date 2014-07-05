namespace :db  do
  desc "import regions db after migrate"
  task :after_migrate => :environment do
    system('psql -d parkstorm_development -c "CREATE EXTENSION postgis;')
    system('psql -d parkstorm_development < db/fixtures/the_business.sql')
  end

  desc "import regions db after test db migrate"
  task :test_after_migrate => :environment do
    system('psql -d parkstorm_test -c "CREATE EXTENSION postgis;')
    system('psql -d parkstorm_test < db/fixtures/the_business.sql')
  end
end