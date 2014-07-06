class Region < ActiveRecord::Base
	has_many :notifications
	has_many :users, through: :notifications

  def self.find_by_location(lat, long)
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3),
    ST_MakePoint(#{long}, #{lat})) <= 0;"

    if found_section = Region.connection.execute(query).first
      Region.find_by_ward_secti(found_section["ward_secti"])
    else
      found_section
    end
  end

  def sections_nearby(distance)
    # Do we need this method or the center method?
    center = find_center
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), \'#{center}\') <= #{distance} * 1609.34;"

    result = []
    Region.connection.execute(query).each {|thing| result << Region.find_by_ward_secti(thing["ward_secti"])}
    result
  end

  def cleaning_days
    months = { month_4: 4, month_5: 5, month_6: 6, month_7: 7, month_8: 8,
               month_9: 9, month_10: 10, month_11: 11 }
    days = []
    months.keys.each do |key|
      day_string = self.send(key)
      if day_string
        day_string.split(",").each do |day|
          days << Date.new(2014,months[key],day.to_i)
        end
      end
    end
    days
  end

  def future_cleaning_days
    cleaning_days.select { |day| day >= Date.today }
  end

  def next_cleaning_day
    today = Date.today
    cleaning_days.sort.find { |day| day >= today }
  end

  def swept_soon?
    week_from_now = Date.today + 7
    if next_cleaning_day
      week_from_now >= next_cleaning_day
    else
      false
    end
  end

  def self.areas_to_display(location, distance)
    query = "SELECT ST_AsGeoJSON(geom), ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), 'MULTIPOINT(#{location[1]} #{location[0]})') <= #{distance} * 1609.34;"
    results = [[],[]]
    Region.connection.execute(query).each do |ward|
      region = Region.find_by_ward_secti(ward["ward_secti"])
      if region.swept_soon?
        results[0] << ward["st_asgeojson"]
      else
        results[1] << ward["st_asgeojson"]
      end
    end
    results
  end

  private

  def find_center
    query = "SELECT ST_AsText(ST_CollectionExtract(ST_GeomFromText(\'#{self.geom}\'),1));"

    Region.connection.execute(query).first.first[1]
  end
end
# SELECT ward_secti FROM regions WHERE ST_DISTANCE_SPHERE(geom, ST_MakePoint(-87.637280, 41.890011)) <= 0;
