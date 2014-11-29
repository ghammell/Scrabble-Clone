class CoordinatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update_letter
    @coordinate = Coordinate.find(params["id"])
    @coordinate.update_attribute('letter', params["value"].squish)
    @droppable_ids = determine_droppable_coordinates.map{|coord| coord.id}

    update_word(@coordinate)
  end

  def submit_word
    @coordinates = session[:current_word].map {|hash| Coordinate.find(hash['id'])}
    sorted_coordinates = sort_coords(@coordinates)
    word = sorted_coordinates.map {|coord| coord.letter}.join.downcase
    if CoordinatesHelper::VerifyWord.valid_placement?(sorted_coordinates)
      @result = check_dictionary(word)
      if @result
        @droppable_ids = determine_droppable_coordinates.map{|coord| coord.id}
        @points = @result.points
        update_player_session
        @letters = get_letters(@coordinates.length).map {|letter| ('A'..'Z').to_a.index(letter)}
        session[:current_word] = []
      else
        @errors = "Sorry, that word is not a valid word."
      end
    else
      @errors = "Sorry, that placemenent is invalid."
    end
  end

  def determine_droppable_coordinates
    game = Game.find(session[:game])
    taken = game.coordinates.select {|coord| coord.letter != ''}
    available = taken.map {|coord| get_available_based_off_single_coordinate(game, coord)}.flatten.uniq
  end

  def get_available_based_off_single_coordinate(game, coordinate)
    ul = [coordinate.horizontal - 1, coordinate.vertical - 1]
    u = [coordinate.horizontal, coordinate.vertical - 1]
    ur = [coordinate.horizontal + 1, coordinate.vertical - 1 ]
    r = [coordinate.horizontal + 1, coordinate.vertical]
    dr = [coordinate.horizontal + 1, coordinate.vertical + 1]
    d = [coordinate.horizontal, coordinate.vertical + 1]
    dl = [coordinate.horizontal - 1, coordinate.vertical + 1]
    l = [coordinate.horizontal - 1, coordinate.vertical]

    near_by = [ul, u, ur, r, dr, d, dl, l]
    near_by.map! {|position| game.coordinates.find_by(horizontal: position[0], vertical: position[1])}
    near_by.compact.select {|coord| coord.letter == ''}
  end

  def update_player_session
    if session[:player] == 1
      @player = 1
      session[:player] = 2
    else
      @player = 2
      session[:player] = 1
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
    @droppable_ids = determine_droppable_coordinates.map{|coord| coord.id}
  end

  def update_word(coordinate)
    session[:current_word] << {id: @coordinate.id, letter: @coordinate.letter}
  end
end
