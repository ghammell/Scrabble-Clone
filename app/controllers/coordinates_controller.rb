class CoordinatesController < ApplicationController
  def update_letter
    @coordinate = Coordinate.find(params["id"])
    @coordinate.update_attribute('letter', params["value"].squish)
    update_word(@coordinate)
    render nothing: true
  end

  def submit_word
    @coordinates = session[:current_word].map {|hash| Coordinate.find(hash['id'])}
    sorted_coordinates = sort_coords(@coordinates)
    sorted_letters = sorted_coordinates.map {|coord| coord.letter}
    if CoordinatesHelper::VerifyWord.valid_placement?(sorted_coordinates)
      check_dictionary(sorted_letters.join.downcase)
    else
      p "INVALID WORD PLACEMENT"
    end
  end

  def sort_coords(coordinates)
    coordinates.sort_by {|coord| coord.vertical}.sort_by{|coord| coord.horizontal}
  end

  def check_dictionary(word)
    DictionaryWord.find_by(word: word)
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
