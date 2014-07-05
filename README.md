## README [![Build Status](https://travis-ci.org/kaplali/parkstorm.svg?branch=master)](https://travis-ci.org/kaplali/parkstorm)
###Git Work-flow:

**To start working on the app:**          

git clone repo    
git pull origin master      
git checkout -b "your_branch_name"    

**To submit a pull request:**            

git checkout "your_branch_name"      
git add your changes      
git commit your changes      
git checkout master     
git pull/fetch origin master       
git checkout "your_branch_name"       
git merge master (if MERGE CONFLICTS exist, resolve them)        
git add and commit any changes      
git push origin "your_branch_name"        

Lastly, submit a pull request on Github     



###How to setup the database

####The very first time you need the database, set up PostGIS:
[PostGIS](http://postgis.net/) extends Postgres so that it can include geospatial data that can then be queried.

For OSX users, ``brew install postgis``.

For Linux users, see [this link](http://www.google.com) for directions to install PostGIS.

####Every time you need to create the database, do this:

1. ``rake db:create``
2. ``rake db:migrate``
3. ``rake db:after_migrate``  This task populates the ``regions`` table in the database with the map data.

To verify that all this worked, open the Rails console and check that there are 888 regions (``Region.all.count``) and also that ``Region.first`` doesn't throw an error message.

See [this link](http://www.bigfastblog.com/landsliding-into-postgis-with-kml-files) for more details (some of the details are irrelevant).



## Other cool stuff

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
