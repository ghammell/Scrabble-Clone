class Game < ActiveRecord::Base
  after_save :create_coordinates
  has_many :coordinates

  def create_coordinates
    mult_spots = [0, 3, 7, 11, 14]
    count = 0
    (0..14).each do |row|
      i = 0
      (0..14).each do |column|
        coordinate = self.coordinates.create(horizontal: row, vertical: column)
        if mult_spots.include?(coordinate.vertical) && mult_spots.include?(coordinate.horizontal)
          unless count == 112
            coordinate.update_attribute("multiple", (2..4).to_a.sample)
            if i == 0
              coordinate.update_attribute("multiplier", 'W')
              i = 1
            else
              coordinate.update_attribute("multiplier", 'L')
              i = 0
            end
          end
        end
        count += 1
      end
    end
  end
end
