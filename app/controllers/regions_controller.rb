class RegionsController < ApplicationController

  def index
    @today = Date.today
    @week_from_today = Date.today + 7
  end

  def current_position
    lat = params['latitude']
    long = params['longitude']
    region = Region.find_by_location(lat, long)
    if region
      session[:current_region_id] = region.id
      if region.next_cleaning_day
        next_sweep = "#{Date::MONTHNAMES[region.next_cleaning_day.month]} #{region.next_cleaning_day.day}"
      else
        next_sweep = "No scheduled cleaning"
      end

      render json: { next_sweep: next_sweep, sweep_days: region.future_cleaning_days_formatted[0..15] }
    else
      render json: { next_sweep: "Not a Chicago Location", sweep_days: ["None"] }
    end
  end

  def load_region
    render partial: 'map', locals: find_region(params)
  end

  def load_region_from_address
    render partial: 'address_map', locals: find_region(params)
  end

  private

  def find_region(args)
    lat = args['latitude']
    long = args['longitude']
    start_date = Date.parse(args['date'][0])
    end_date = Date.parse(args['date'][1])
    regions = Region.areas_by_date_range([lat, long], start_date, end_date)
    { regions: regions, lat: lat, long: long }
  end
end


