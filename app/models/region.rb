class Region < ActiveRecord::Base
	has_many :notifications
	has_many :users, through: :notifications

  def self.find_by_location(lat, long)
    Region.where("ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), ST_MakePoint(#{long}, #{lat})) <= 0").first
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

  def future_cleaning_days_formatted
    collect_dates = Hash.new
    future_cleaning_days.each do |date|
      month_name = Date::MONTHNAMES[date.month]
      collect_dates[month_name] ||= []
      collect_dates[month_name] << date.day.ordinalize
    end
    collect_dates

    collect_dates.map{|month, days| [month, days]}
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

  def swept_in_date_range?(start_date=Date.today, end_date=Date.today + 7)
    swept = false
    cleaning_days.each { |day| swept = true if (day >= start_date && day <= end_date) }
    swept
  end

  def display_self
    if next_cleaning_day    
      next_cleaning = "#{Date::MONTHNAMES[next_cleaning_day.month]} #{next_cleaning_day.day}"
    else
      next_cleaning = "none"
    end
    { name: "Ward #{ward_num} Area #{sweep}", next_sweep: "Next cleaning day: #{next_cleaning}" }
  end

  def to_geojson
    Region.select("*, ST_AsGeoJSON(geom) as my_geo").where(gid: id)
  end

  def self.get_regions(location, distance)
    Region.select("*, ST_AsGeoJSON(geom) as my_geo").where("ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), 'MULTIPOINT(#{location[1]} #{location[0]})') <= #{distance} * 1609.34")
  end

  def self.areas_by_date_range(location, start_date=(Date.today), end_date=(Date.today + 7))
    results = [[],[]]
    regions = Region.get_regions(location, 0.25)
    regions.each do |ward|
      if ward.swept_in_date_range?(start_date, end_date)
        results[0] << ward.my_geo
      else
        results[1] << ward.my_geo
      end
    end
    results
  end

  def get_region_obj(json_obj)
    region = json_obj[0][0]
    region_obj = JSON.parse(region)
    marker_coords = region_obj["geometries"][0]["coordinates"]
    Region.where("ST_DISTANCE_SPHERE(ST_CollectionExtract(geom, 3), ST_MakePoint(#{marker_coords[1]}, #{marker_coords[0]})) <= 0").first
  end
end
