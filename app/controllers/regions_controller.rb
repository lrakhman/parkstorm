class RegionsController < ApplicationController

  def current_position
    lat = params['latitude']
    long = params['longitude']
    region = Region.find_by_location(lat, long)
    session[:current_region] = region
    if region.next_cleaning_day
      next_sweep = "#{Date::MONTHNAMES[region.next_cleaning_day.month]} #{region.next_cleaning_day.day}"
    else
      next_sweep = "No scheduled cleaning"
    end

    render json: { next_sweep: next_sweep, sweep_days: region.future_cleaning_days[0..15] } 
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
    regions = Region.areas_to_display([lat, long], 0.25)
    { regions: regions, lat: lat, long: long }
  end
end
