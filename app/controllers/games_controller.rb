class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @game = Game.create
    @coordinates = @game.coordinates.sort_by {|coord| coord.id}
    @p1_hand = get_hand(7)
    @p2_hand = get_hand(7)
    session[:current_word] = []
    session[:player] = 1
    session[:game] = @game.id
  end

  def get_hand(num)
    vowels = ['A','E','I','O','U']
    alphabet = ('A'..'Z').to_a - vowels
    (0..num).map {|num| num.even? ? alphabet.sample : vowels.sample}
  end

  def get_letter(num)
    ('A'..'Z').to_a.sample
  end
end
