module CoordinatesHelper
  class VerifyWord
    def self.valid_placement?(coordinates)
      coordinates.map {|coord| [coord.vertical, coord.horizontal]}
      (1...coordinates.length).each do |index|
        previous = [coordinates[index-1].vertical, coordinates[index-1].horizontal]
        current = [coordinates[index].vertical, coordinates[index].horizontal]
        return false if test_all(current, previous) == false
      end
      return true
    end

    def self.test_all(current, previous)
      return true if test_vertical(current, previous) == true
      return true if test_horizontal(current, previous) == true
      return test_diagonal(current, previous)
    end

    def self.test_vertical(current, previous)
      (current[0] == previous[0]) && (current[1] == previous[1] + 1)
    end

    def self.test_horizontal(current, previous)
      (current[0] == previous[0] + 1) && (current[1] == previous[1])
    end

    def self.test_diagonal(current, previous)
      (current[0] == previous[0] + 1) && (current[1] == previous[1] + 1)
    end
  end
end
