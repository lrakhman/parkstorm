class RegionsController < ApplicationController

  def index
    # load a map of chicago
    # @regions = Region.areas_to_display([41.905585, -87.631297], 100)
  end

  def load_region
    lat = params['latitude']
    long = params['longitude']

    @region = Region.find_by_location(lat, long)

    respond_to do |format|
      format.js {render :json => @region}
    end
  end

  def load_surrounding_regions
    lat = params['latitude']
    long = params['longitude']
    if Rails.cache.fetch('map1') && Rails.cache.fetch('map2') && Rails.cache.fetch('map3') && Rails.cache.fetch('map4') && Rails.cache.fetch('map5')
      @regions = [Rails.cache.fetch('map1'), Rails.cache.fetch('map2') + Rails.cache.fetch('map3') + Rails.cache.fetch('map4') + Rails.cache.fetch('map5')]
    else
      all_regions = Region.areas_to_display([lat, long], 100)
      Rails.cache.write('map1', all_regions[0])
      first_quarter = all_regions[1][0..all_regions.length/4]
      last_three_quarters = all_regions[1] - first_quarter
      second_quarter = last_three_quarters[0..last_three_quarters.length/3]
      second_half = last_three_quarters - second_quarter
      third_quarter = second_half[0..second_half.length/2]
      fourth_quarter = second_half - third_quarter
      Rails.cache.write('map2', first_quarter)
      Rails.cache.write('map3', second_quarter)
      Rails.cache.write('map4', third_quarter)
      Rails.cache.write('map5', fourth_quarter)
      @regions = [Rails.cache.fetch('map1'), Rails.cache.fetch('map2') + Rails.cache.fetch('map3') + Rails.cache.fetch('map4') + Rails.cache.fetch('map5')]
    end
    render partial: 'map', locals: {regions: @regions}
  end
end
