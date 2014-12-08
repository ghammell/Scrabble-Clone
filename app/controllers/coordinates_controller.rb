class CoordinatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update_letter
    @coordinate = Coordinate.find(params["id"])
    CoordinatesHelper.update_neighbors(session[:game], @coordinate)
    @coordinate.update_attribute('letter', params["value"].squish)
    @droppable_ids = CoordinatesHelper.determine_droppable_coordinates(session[:game]).map{|coord| coord.id}
    update_word(@coordinate)
  end

  def submit_word
    @coordinates = session[:current_word].map {|hash| Coordinate.find(hash['id'])}
    @coordinate_ids = @coordinates.map {|coord| coord.id}
    @words = CoordinatesHelper::VerifyWord.valid_placement?(@coordinates)

    if @words
      @droppable_ids = CoordinatesHelper.determine_droppable_coordinates(session[:game]).map{|coord| coord.id}
      @results = @words.map {|word| [word[0].word, word[0].points]}
      update_player_session
      @letters = get_letters(@coordinates.length).map {|letter| ('A'..'Z').to_a.index(letter)}
      session[:current_word] = []
    else
      @errors = "Sorry, that placemenent is invalid."
    end
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
    (0...num).map do |num|
      decimal = rand()
      vowels = ['A','E','I','O','U']
      if decimal < 0.33
        vowels.sample
      else
        (('A'..'Z').to_a - vowels).sample
      end
    end
  end

  def reset_word
    session[:current_word].each {|hash| Coordinate.find(hash['id']).update_attribute('letter', '')}
    @reset_ids = session[:current_word].map{|hash| hash['id']}
    @letters = session[:current_word].map {|hash| ('A'..'Z').to_a.index(hash['letter'])}
    @player = session[:player]
    session[:current_word] = []
    @droppable_ids = CoordinatesHelper.determine_droppable_coordinates(session[:game]).map{|coord| coord.id}
  end

  def update_word(coordinate)
    session[:current_word] << {id: @coordinate.id, letter: @coordinate.letter}
  end
end
