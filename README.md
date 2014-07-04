== README

How to setup the database

Notice  ``db/fixtures/the_business.sql``.  The data in this file needs to be added to the postgres database for the application.  Directions as follows:

0. The first time you setup the database, do this in your terminal.  Every subsequent build should not require this step, even if you have dropped the postgres database.

```TEMPLATE_DB_NAME=template_postgis

# Create the template spatial database.
createdb -E UTF8 $TEMPLATE_DB_NAME

# Add PLPGSQL language support.
createlang -d $TEMPLATE_DB_NAME plpgsql

# Load the PostGIS extensions
for SQL_NAME in postgis postgis_comments spatial_ref_sys
do
    psql -d $TEMPLATE_DB_NAME -f /usr/local/Cellar/postgis/1.5.2/share/postgis/$SQL_NAME.sql
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

1. ``DB_NAME="parkstorm_development"
DB_USER="catherine_is_super_cool"

createuser --no-superuser --createdb --no-createrole $DB_USER
createdb --template=template_postgis --encoding=UTF8 --owner=$DB_USER $DB_NAME
echo "GRANT ALL ON SCHEMA public TO $DB_USER" | psql $DB_NAME
for t in geography_columns geometry_columns spatial_ref_sys
do
    echo "ALTER TABLE $t OWNER TO $DB_USER" | psql -d $DB_NAME
done``

3. Navigate to db/fixtures

4. Do this in the terminal: ``psql -d $DB_NAME $DB_USER < the_business.sql`` 

see this link for more details (some of the details are irrelevant): http://www.bigfastblog.com/landsliding-into-postgis-with-kml-files




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
