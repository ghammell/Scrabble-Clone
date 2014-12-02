class Friendship < ActiveRecord::Base
  belongs_to :coordinate
  belongs_to :friend, :class_name => "Coordinate"
end
