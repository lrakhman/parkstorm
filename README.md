## README [![Build Status](https://travis-ci.org/kaplali/parkstorm.svg?branch=master)](https://travis-ci.org/kaplali/parkstorm)

###About this App

This application allows users to easily determine the street sweeping schedule for any location in Chicago.

###Dependencies

The application runs on Rails and depends on many of the standard gems that come with a new Rails app.  In addition, Don't Park There Chicago depends on:

* [PostGIS](http://postgis.net/)
  * PostGIS extends Postgres so that it can include geospatial data that can then be queried.  It must be installed before the database can be used.
    * For OSX users, ``brew install postgis``.
    * For Linux users, see [this link](http://www.google.com) for directions to install PostGIS.
  * The [activerecord-postgis-adapter](https://github.com/rgeo/activerecord-postgis-adapter) is included in the Gemfile and provides ActiveRecord query support for PostGIS.  As long as the application has been bundled, the gem should work.

* [Devise](https://github.com/plataformatec/devise)

These dependencies require **ActiveRecord 4.0+** and **Ruby 1.9.3+**.  PostGIS must be version 2.0+


###How to setup the database
Note: The procedure below will not work unless PostGIS is installed.  See above for instructions on installing PostGIS.

1. ``rake db:create``
2. ``rake db:migrate``
3. ``rake db:after_migrate``  This task populates the ``regions`` table in the database with the map data.

To verify that all this worked, open the Rails console and check that there are 888 regions (``Region.all.count``) and also that ``Region.first`` doesn't throw an error message.

###Running the tests

1. ``rake db:test:prepare``
2. ``rake db:test_after_prepare``
3. ``rspec spec``

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

## Where does the data come from?

The data for this app is available from the city of Chicago through [Socrata](http://www.socrata.com/). It can be seen in visual form [here](https://data.cityofchicago.org/Sanitation/Map-Street-Sweeping-2014/czxu-ejis). We accessed the data in kml form which can be had [here](https://data.cityofchicago.org/api/geospatial/czxu-ejis?method=export&format=KML).

To add this kml data into our database (see above for info on setting up the database) we needed to convert the data into SQL commands. As a result we wrote a simple kml parser (see db/fixtures/parsetastic2000.rb in this repository) to do this. Simply type ruby parsetastic2000.rb in your console while in the same directory as both the parsing file and the kml file and it will produce the sql file. The parser is not perfect, so you will likely need to do some cleanup. First, find and replace all 'NULL' with NULL (get rid of those quotes). Then, search for any `<li>` tags in the data and delete the markup. There will likely be around 20 to delete due to imperfections in the data and imperfections in the parsing. Once that is done you will have a sql file that is ready to be imported into a PostGis database. 
