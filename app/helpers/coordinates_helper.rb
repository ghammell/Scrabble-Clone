module CoordinatesHelper
  class VerifyWord
    def self.word_valid?(coordinates)
      coordinates.map {|coord| [coord.vertical, coord.horizontal]}
      (1...coordinates.length).each do |index|
        previous = [coordinates[index-1].vertical, coordinates[index-1].horizontal]
        current = [coordinates[index].vertical, coordinates[index].horizontal]
        return false if test_all(current, previous) == false
      end
      return true
    end

    def self.test_all(current, previous)
      if test_vertical(current, previous) == true
        true
      elsif test_horizontal(current, previous) == true
        true
      else
        return test_diagonal(current, previous)
      end
    end

    def self.test_vertical(current, previous)
      return false if (current[0] != previous[0]) || (current[1] != previous[1] + 1)
      return true
    end

    def self.test_horizontal(current, previous)
      return false if (current[0] != previous[0] + 1) || (current[1] != previous[1])
      return true
    end

    def self.test_diagonal(current, previous)
      return false if (current[0] != previous[0] + 1) || (current[1] != previous[1] + 1)
      return true
    end
  end
end
