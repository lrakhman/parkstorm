class RegionsController < ApplicationController

  def index
    # load a map of chicago
    # @regions = Region.areas_to_display([41.905585, -87.631297], 100)
  end

  def current_position
    lat = params['latitude']
    long = params['longitude']
    region = Region.find_by_location(lat, long)
    session[:current_region_id] = region.id
    if region.next_cleaning_day
      next_sweep = "#{Date::MONTHNAMES[region.next_cleaning_day.month]} #{region.next_cleaning_day.day}"
    else
      next_sweep = "No scheduled cleaning"
    end

    render json: { next_sweep: next_sweep, 
                    sweep_days: region.future_cleaning_days[0..15] } 
  end

  def load_region
    lat = params['latitude']
    long = params['longitude']
    @regions = Region.areas_to_display([lat, long], 0.25)
    render partial: 'map', locals: { regions: @regions, lat: lat, long: long }
  end

  def load_region_from_address
    lat = params['latitude']
    long = params['longitude']
    @regions = Region.areas_to_display([lat, long], 0.25)
    render partial: 'address_map', locals: { regions: @regions, lat: lat, long: long }
  end
end


