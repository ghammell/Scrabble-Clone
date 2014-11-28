class Coordinate < ActiveRecord::Base
  skip_before_action :verify_authenticity_token
  belongs_to :game
end
