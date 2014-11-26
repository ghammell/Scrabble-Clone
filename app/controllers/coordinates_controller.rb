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
    word = sorted_coordinates.map {|coord| coord.letter}.join.downcase
    if CoordinatesHelper::VerifyWord.valid_placement?(sorted_coordinates)
      @result = check_dictionary(word)
      if @result
        @points = @result.points
        @player = session[:player]
        @letters = get_letters(@coordinates.length).map {|letter| ('A'..'Z').to_a.index(letter)}
        session[:current_word] = []
      else
        @errors = "Sorry, that word is not a valid word."
      end
    else
      @errors = "Sorry, that placemenent is invalid."
    end
  end

  def get_letters(num)
    (0...num).map {|num| ('A'..'Z').to_a.sample}
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
