class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @game = Game.includes(:coordinates).create
    @coordinates = @game.coordinates.sort_by {|coord| coord.id}
    @start_coordinate = @coordinates[@coordinates.length / 2]
    @p1_hand = get_hand(7)
    @p2_hand = get_hand(7)
    session[:current_word] = []
    session[:player] = 1
    session[:game] = @game.id
  end

  def get_hand(num)
    vowels = ['A','E','I','O','U']
    alphabet = ('A'..'Z').to_a - vowels
    (0..num).map do |num|
      if num < 3
        vowels.sample
      else
        alphabet.sample
      end
    end
  end

  def get_letter(num)
    ('A'..'Z').to_a.sample
  end
end
