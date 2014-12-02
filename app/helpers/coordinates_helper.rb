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

  def self.determine_droppable_coordinates(game_id)
    game = Game.find(game_id)
    taken = game.coordinates.select {|coord| coord.letter != ''}
    available = taken.map {|coord| get_available_from_coordinate(game, coord)}.flatten.uniq
    if available == []
      game.coordinates
    else
      available
    end
  end

  def self.get_available_from_coordinate(game, coordinate)
    ul = [coordinate.horizontal - 1, coordinate.vertical - 1]
    u = [coordinate.horizontal, coordinate.vertical - 1]
    ur = [coordinate.horizontal + 1, coordinate.vertical - 1 ]
    r = [coordinate.horizontal + 1, coordinate.vertical]
    dr = [coordinate.horizontal + 1, coordinate.vertical + 1]
    d = [coordinate.horizontal, coordinate.vertical + 1]
    dl = [coordinate.horizontal - 1, coordinate.vertical + 1]
    l = [coordinate.horizontal - 1, coordinate.vertical]

    near_by = [ul, u, ur, r, dr, d, dl, l]
    near_by.map! {|position| game.coordinates.find_by(horizontal: position[0], vertical: position[1])}
    near_by.compact.select {|coord| coord.letter == ''}
  end
end
