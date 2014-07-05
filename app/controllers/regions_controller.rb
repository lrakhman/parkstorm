
class RegionsController < ApplicationController
  def index
    # load zoomed out map centered on chicago
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
    @regions = Region.areas_to_display([lat, long], 4)
    render partial: 'map', locals: {regions: @regions}
    # respond_to do |format|
    #   format.js {render :json => @regions}
    # end
  end

end
