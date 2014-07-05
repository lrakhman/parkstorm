namespace :db  do
  desc "import regions db after migrate"
  task :after_migrate => :environment do
    # open database
    system('psql -d parkstorm_development -c "CREATE EXTENSION postgis;')
    # system('CREATE EXTENSION postgis;')
    # system('\q')
    system('psql -d parkstorm_development < db/fixtures/the_business.sql')
    # add regions table to db
  end
end