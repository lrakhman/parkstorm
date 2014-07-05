class RegionsController < ApplicationController
  def index
    @regions = Region.areas_to_display([41.905585, -87.631297], 100)
  end
end
