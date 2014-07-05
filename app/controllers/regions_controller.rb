
class RegionsController < ApplicationController
  def index
    # load a map of chicago
    # @regions = Region.areas_to_display([41.905585, -87.631297], 100)
  end

  def load_region
    lat = params['latitude']
    long = params['longitude']

    region = Region.find_by_location(lat, long)


    @region = Region.areas_to_display([lat, long], 0).flatten[0]


    render partial: 'local_map', locals: {region: @region, swept_soon: region.swept_soon?}
  end

  def load_surrounding_regions
    lat = params['latitude']
    long = params['longitude']
    @regions = Region.areas_to_display([lat, long], 1)
    render partial: 'map', locals: {regions: @regions}
    # respond_to do |format|
    #   format.js {render :json => @regions}
    # end
  end

end
