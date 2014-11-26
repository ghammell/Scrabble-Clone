class GamesController < ApplicationController
  def create
    session[:current_word] = []
    session[:player] = 1
    @game = Game.create
    @coordinates = @game.coordinates
    @p1_hand = get_hand(7)
    @p2_hand = get_hand(7)
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
