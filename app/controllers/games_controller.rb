class GamesController < ApplicationController
  def create
    @game = Game.create
    @coordinates = @game.coordinates
    @p1_hand = get_pieces(7)
    @p2_hand = get_pieces(7)
  end

  def get_pieces(num)
    alphabet = ('A'..'Z').to_a
    (0..num).map {|num| alphabet.sample}
  end
end
