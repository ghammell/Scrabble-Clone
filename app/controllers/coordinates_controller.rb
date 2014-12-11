class CoordinatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_game, only: [:update_letter, :reset_word, :submit_word]

  def get_game
    @game = Game.includes(:coordinates).find(session[:game])
  end

  def update_letter
    @coordinate = Coordinate.includes(:friends).find(params["id"])
    CoordinatesHelper.update_neighbors(@game, @coordinate)
    @coordinate.update_attribute('letter', params["value"].squish)
    @droppable = CoordinatesHelper.determine_droppable_coordinates(@game)
    update_word(@coordinate)
  end

  def submit_word
    @coordinates = session[:current_word].map {|hash| @game.coordinates.find(hash['id'])}
    @words = CoordinatesHelper::VerifyWord.valid_placement?(@game, @coordinates)

    if @words
      @results = @words.map {|word| [word[0].word, word[0].points]}
      update_player_session
      @letters = get_letters(@coordinates.length)
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
      vowels = ['A','E','I','O','U']
      if rand() < 0.33
        vowels.sample
      else
        (('A'..'Z').to_a - vowels).sample
      end
    end
  end

  def reset_word
    session[:current_word].each {|hash| @game.coordinates.find(hash['id']).update_attribute('letter', '')}
    @reset_ids = session[:current_word].map{|hash| hash['id']}
    @letters = session[:current_word].map {|hash| hash['letter']}
    @player = session[:player]
    session[:current_word] = []
    @droppable = CoordinatesHelper.determine_droppable_coordinates(@game)
  end

  def update_word(coordinate)
    session[:current_word] << {id: @coordinate.id, letter: @coordinate.letter}
  end
end
