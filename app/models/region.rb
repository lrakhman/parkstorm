class Region < ActiveRecord::Base
	has_many :notifications
	has_many :users, through: :notifications

  def self.find_ward_section(lat, long)
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3),
    ST_MakePoint(#{long}, #{lat})) <= 0;"

    Region.connection.execute(query).first
  end

  def sections_nearby(distance)
    center = find_center
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), \'#{center}\') <= #{distance} * 1609.34;"

    result = []
    Region.connection.execute(query).each {|thing| result << thing}
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

  def next_cleaning_day
    today = Date.today
    cleaning_days.sort.find { |day| day > today }
  end

  private
  def find_center
    query = "SELECT ST_AsText(ST_CollectionExtract(ST_GeomFromText(\'#{self.geom}\'),1));"

    Region.connection.execute(query).first.first[1]
  end
end
# SELECT ward_secti FROM regions WHERE ST_DISTANCE_SPHERE(geom, ST_MakePoint(-87.637280, 41.890011)) <= 0;
