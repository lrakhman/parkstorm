class Region < ActiveRecord::Base
	has_many :notifications
	has_many :users, through: :notifications

  def self.find_ward_section(lat, long)
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(geom,
    ST_MakePoint(#{lat}, #{long})) <= 0;"

    Region.connection.execute(query).first
  end

  def sections_nearby(distance)
    center = find_center
    query = "SELECT ward_secti FROM regions 
    WHERE ST_DISTANCE_SPHERE(geom, \'#{center}\') <= #{distance} * 1609.34;"

    result = []
    Region.connection.execute(query).each {|thing| result << thing}
    result
  end

  def get_geo
    query = "SELECT ST_AsGeoJSON(geom) FROM regions WHERE ward_secti = '#{self.ward_secti}';"

    ward1 = Region.connection.execute(query).first
    ward1["st_asgeojson"].gsub(/\"/, "\"")
  end

  private
  def find_center
    query = "SELECT ST_AsText(ST_CollectionExtract(ST_GeomFromText(\'#{self.geom}\'),1));"

    Region.connection.execute(query).first.first[1]
  end
end
