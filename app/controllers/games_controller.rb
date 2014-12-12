class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @game = Game.includes(:coordinates).create
    @coordinates = @game.coordinates.sort_by {|coord| coord.id}
    @start_coordinate = @coordinates[@coordinates.length / 2]
    @p1_hand = get_hand(8)
    @p2_hand = get_hand(8)
    session[:current_word] = []
    session[:player] = 1
    session[:game] = @game.id
  end

  def get_hand(num)
    vowels = ['A','E','I','O','U']
    alphabet = ('A'..'Z').to_a - vowels
    hand = []
    until hand.length == num
      letter = (num < 3 ? vowels.sample : alphabet.sample)
      next if hand.count(letter) == 2
      hand << letter
    end
    hand
  end
end
