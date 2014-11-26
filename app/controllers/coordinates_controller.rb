class CoordinatesController < ApplicationController
  def update_letter
    @coordinate = Coordinate.find(params["id"])
    @coordinate.update_attribute('letter', params["value"].squish)
    update_word(@coordinate)
    render nothing: true
  end

  def submit_word
  end

  def reset_word
  end

  def update_word(coordinate)
    session[:current_word] << @coordinate
    p session[:current_word]
  end
end
