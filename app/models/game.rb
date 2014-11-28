class Game < ActiveRecord::Base
  skip_before_action :verify_authenticity_token
  after_save :create_coordinates
  has_many :coordinates

  def create_coordinates
    (0..14).each do |row|
      (0..14).each {|column| self.coordinates.create(horizontal: row, vertical: column) }
    end
  end
end
