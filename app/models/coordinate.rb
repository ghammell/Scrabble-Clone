class Coordinate < ActiveRecord::Base
  has_many :friendships
  has_many :friends, :through => :friendships
  belongs_to :game
end
