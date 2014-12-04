class Game < ActiveRecord::Base
  after_save :create_coordinates
  has_many :coordinates

  def create_coordinates
    mult_spots = [0, 3, 7, 10, 14]
    (0..14).each do |row|
      i = 0
      (0..14).each do |column|
        coordinate = self.coordinates.create(horizontal: row, vertical: column)
        if mult_spots.include?(coordinate.vertical) && mult_spots.include?(coordinate.horizontal)
          coordinate.multiple = rand(3) + 1
          if i == 0
            coordinate.multiplier = 'word'
            i = 1
          else
            coordinate.multiplier = 'letter'
            i = 0
          end
        end
      end
    end
  end
end
