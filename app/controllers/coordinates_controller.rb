class CoordinatesController < ApplicationController
  def update_letter
    @coordinate = Coordinate.find(params["id"])
    @coordinate.update_attribute('letter', params["value"].squish)
    render nothing: true
  end
end
