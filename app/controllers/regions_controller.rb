
class RegionsController < ApplicationController
  def index
    # load zoomed out map centered on chicago
  end

  def load_region
    lat = params['latitude']
    long = params['longitude']
    # do we want to send back current location of user?  right now, we only send the region
    region = Region.find_by_location(lat, long).to_json
    respond_to do |format|
      format.js {render :json => region}
    end
  end

  def load_surrounding_regions
    lat = params['latitude']
    long = params['longitude']
    respond_to do |format|
      format.js {render :json => 3}
    end
  end

  private
  def get_region_info(region)
    # return hash of all info the view needs about a region
  end
end
