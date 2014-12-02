class Coordinate < ActiveRecord::Base
  has_many :neighbors, class_name: "Coordinate", foreign_key: "neighbor_id"
  belongs_to :neighbor, class_name: "Coordinate"
  belongs_to :game
end
