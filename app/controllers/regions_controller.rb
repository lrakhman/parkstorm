
include Geokit::Geocoders

class RegionsController < ApplicationController
  def index
    # load zoomed out map centered on chicago
  end

  def load_index
    if request.xhr?
      logger.info params
      params['longitutde']
      params['latitude']
       # send back map data
    end
  end
end
