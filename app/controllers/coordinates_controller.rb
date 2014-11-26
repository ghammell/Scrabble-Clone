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
    session[:current_word].each {|hash| Coordinate.find(hash['id']).update_attribute('letter', '')}
    @letters = session[:current_word].map {|hash| hash['letter']}
    @reset_ids = session[:current_word].map{|hash| hash['id']}
    session[:current_word] = []
  end

  def update_word(coordinate)
    session[:current_word] << {id: @coordinate.id, letter: @coordinate.letter}
    p session[:current_word]
  end
end
