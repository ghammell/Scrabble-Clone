module CoordinatesHelper
  class VerifyWord
    def self.word_valid?(coordinates)
      if test_vertical(coordinates) == true
        true
      elsif test_horizontal(coordinates) == true
        true
      else
        return test_diagonal(coordinates)
      end
    end

    def self.test_vertical(coordinates)
      coordinates.map {|coord| [coord.vertical, coord.horizontal]}
      (1...coordinates.length).each do |index|
        previous = [coordinates[index-1].vertical, coordinates[index-1].horizontal]
        current = [coordinates[index].vertical, coordinates[index].horizontal]
        return false if (current[0] != previous[0]) || (current[1] != previous[1] + 1)
      end
      return true
    end

    def self.test_horizontal(coordinates)
      coordinates.map {|coord| [coord.vertical, coord.horizontal]}
      (1...coordinates.length).each do |index|
        previous = [coordinates[index-1].vertical, coordinates[index-1].horizontal]
        current = [coordinates[index].vertical, coordinates[index].horizontal]
        return false if (current[0] != previous[0] + 1) || (current[1] != previous[1])
      end
      return true
    end

    def self.test_diagonal(coordinates)
      coordinates.map {|coord| [coord.vertical, coord.horizontal]}
      (1...coordinates.length).each do |index|
        previous = [coordinates[index-1].vertical, coordinates[index-1].horizontal]
        current = [coordinates[index].vertical, coordinates[index].horizontal]
        return false if (current[0] != previous[0] + 1) || (current[1] != previous[1] + 1)
      end
      return true
    end

  end
end
