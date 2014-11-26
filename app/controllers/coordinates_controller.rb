class CoordinatesController < ApplicationController
  def update_letter
    @coordinate = Coordinate.find(params["id"])
    @coordinate.update_attribute('letter', params["value"].squish)
    update_word(@coordinate)
    render nothing: true
  end

  def submit_word
    @coordinates = session[:current_word].map {|hash| Coordinate.find(hash['id'])}
    p CoordinatesHelper::VerifyWord.word_valid?(sort_word(@coordinates))
  end

  def sort_word(coordinates)
    coordinates.sort_by {|coord| coord.vertical}.sort_by{|coord| coord.horizontal}
  end

  def reset_word
    session[:current_word].each {|hash| Coordinate.find(hash['id']).update_attribute('letter', '')}
    @reset_ids = session[:current_word].map{|hash| hash['id']}
    @letters = session[:current_word].map {|hash| ('A'..'Z').to_a.index(hash['letter'])}
    @player = session[:player]
    session[:current_word] = []
  end

  def update_word(coordinate)
    session[:current_word] << {id: @coordinate.id, letter: @coordinate.letter}
  end
end
