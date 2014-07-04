## README

###How to setup the database

Notice  ``db/fixtures/the_business.sql``.  The data in this file needs to be added to the postgres database for the application.  

**NOTE: Unfortunately, you cannot copy multiple lines from this file at a time -- the terminal doesn't like it.**

####The very first time you need the database, set up PostGIS:
[PostGIS](http://postgis.net/) extends Postgres so that it can include geospatial data that can then be queried.

1. ``brew install postgis``

2. Type the following into the command line:
```
TEMPLATE_DB_NAME=template_postgis

# Create the template spatial database.
createdb -E UTF8 $TEMPLATE_DB_NAME

# Add PLPGSQL language support.
createlang -d $TEMPLATE_DB_NAME plpgsql

# Load the PostGIS extensions
for SQL_NAME in postgis postgis_comments spatial_ref_sys
do
    psql -d $TEMPLATE_DB_NAME -f /usr/local/Cellar/postgis/2.1.3/share/postgis/$SQL_NAME.sql
done

# Finalize our PostGIS template database
cat <<EOS | psql -d $TEMPLATE_DB_NAME
UPDATE pg_database SET datistemplate = TRUE WHERE datname = '$TEMPLATE_DB_NAME';
REVOKE ALL ON SCHEMA public FROM public;
GRANT USAGE ON SCHEMA public TO public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.geometry_columns TO PUBLIC;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.spatial_ref_sys TO PUBLIC;
VACUUM FULL FREEZE;
EOS 
```
Some notes:
* If you get the error ``ERROR:  role "postgres" does not exist``, enter ``createuser -s -r postgres``.
* If you get partway through this and it fails, google the error.  **After fixing the error**, be sure to ``rake db:drop`` the database from inside the rails app.  You do NOT need to ``rake db:create``; that's what we're doing in the block of code above.

####Every time you need to create the database, do this:

1)
```
DB_NAME="parkstorm_development"
DB_USER="<enter the name of your computer>"
# for example, DB_USER="catherine"

createuser --no-superuser --createdb --no-createrole $DB_USER
createdb --template=template_postgis --encoding=UTF8 --owner=$DB_USER $DB_NAME
echo "GRANT ALL ON SCHEMA public TO $DB_USER" | psql $DB_NAME
for t in geography_columns geometry_columns spatial_ref_sys
do
    echo "ALTER TABLE $t OWNER TO $DB_USER" | psql -d $DB_NAME
done
```
2) In your terminal, navigate to db/fixtures

3) Do this in the terminal: ``psql -d $DB_NAME $DB_USER < the_business.sql`` 

4) From the Rails app, ``rake db:migrate`` to add the other tables (besides ``regions``).

To verify that all this worked, open the Rails console and check that there are 888 regions (``Region.all.count``).

See [this link](http://www.bigfastblog.com/landsliding-into-postgis-with-kml-files) for more details (some of the details are irrelevant).



## Other cool stuff

## Where does the data come from?

The data for this app is available from the city of Chicago through [Socrata](http://www.socrata.com/). It can be seen in visual form [here](https://data.cityofchicago.org/Sanitation/Map-Street-Sweeping-2014/czxu-ejis). We accessed the data in kml form which can be had [here](https://data.cityofchicago.org/api/geospatial/czxu-ejis?method=export&format=KML).

To add this kml data into our database (see above for info on setting up the database) we needed to convert the data into SQL commands. As a result I wrote a simple kml parser (see db/fixtures/parsetastic2000.rb in this repository) to do this. Simply type ruby parsetastic2000.rb in your console while in the same directory as both the parsing file and the kml file and it will produce the sql file. The parser is not perfect, so you will likely need to do some cleanup. First, find and replace all 'NULL' with NULL (get rid of those quotes). Then, search for any <li> tags in the data and delete the markup. There will likely be around 20 to delete due to imperfections in the data and imperfections in the parsing. Once that is done you will have a sql file that is ready to be imported into a PostGis database. 
