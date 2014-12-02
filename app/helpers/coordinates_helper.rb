module CoordinatesHelper
  class VerifyWord
    def self.valid_placement?(coordinates)
      if check_placement(sort_coords(coordinates))
        check_connection_words(coordinates)
      end
    end

    def self.check_connection_words(coordinates)
      v_words = []
      h_words = []
      coordinates.each do |coord|
        h_response = check_horizontal(coord)
        if h_response == false
          return false
        elsif h_words.include?(h_response) == false
          h_words << h_response
        end

        v_response = check_vertical(coord)
        if v_response == false
          return false
        elsif v_words.include?(v_response) == false
          v_words << v_response
        end
      end
      (v_words + h_words).select {|dict_word| dict_word.word.length > 1}
    end

    def self.check_horizontal(coordinate)
      full_word = get_coords_in_direction(coordinate, -1, 0) + get_coords_in_direction(coordinate, 1, 0)
      word = full_word.uniq.map {|coord| coord.letter}.join
      dict_result = check_dictionary(word.downcase)
      dict_result == nil ? false : dict_result
    end

    def self.check_vertical(coordinate)
      full_word = get_coords_in_direction(coordinate, 0, -1) + get_coords_in_direction(coordinate, 0, 1)
      word = full_word.uniq.map {|coord| coord.letter}.join
      dict_result = check_dictionary(word.downcase)
      dict_result == nil ? false : dict_result
    end

    def self.get_coords_in_direction(coordinate, v_direction, h_direction, group=[])
      group += [coordinate]
      neighbor = coordinate.friends.find_by(horizontal: coordinate.horizontal + h_direction, vertical: coordinate.vertical + v_direction)
      if neighbor == nil || neighbor.letter == "" then return sort_coords(group) end
      get_coords_in_direction(neighbor, v_direction, h_direction, group)
    end

    def self.get_neighbors(coordinate, coordinates)
      filled_neighbors = coordinates.map {|coord| coord.friends - coordinates}
      return true
    end

    def self.check_dictionary(word)
      DictionaryWord.find_by(word: word)
    end

    def self.sort_coords(coordinates)
      coordinates.sort_by {|coord| coord.vertical}.sort_by{|coord| coord.horizontal}
    end

    def self.check_placement(coordinates)
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
      return test_horizontal(current, previous)
    end

    def self.test_vertical(current, previous)
      (current[0] == previous[0]) && (current[1] == previous[1] + 1)
    end

    def self.test_horizontal(current, previous)
      (current[0] == previous[0] + 1) && (current[1] == previous[1])
    end
  end

  def self.determine_droppable_coordinates(game_id)
    game = Game.find(game_id)
    taken = game.coordinates.select {|coord| coord.letter != ''}
    available = taken.map {|coord| get_available_neighbors(game, coord)}.flatten.uniq
    if available == []
      game.coordinates
    else
      available
    end
  end

  def self.get_neighbor_coordinates(game, coordinate)
    u = [coordinate.horizontal, coordinate.vertical - 1]
    r = [coordinate.horizontal + 1, coordinate.vertical]
    d = [coordinate.horizontal, coordinate.vertical + 1]
    l = [coordinate.horizontal - 1, coordinate.vertical]

    near_by = [u, r, d, l]
    near_by.map! {|position| game.coordinates.find_by(horizontal: position[0], vertical: position[1])}.compact
  end

  def self.get_available_neighbors(game, coordinate)
    get_neighbor_coordinates(game, coordinate).select {|coord| coord.letter == ''}
  end

  def self.update_neighbors(game_id, coordinate)
    game = Game.find(game_id)
    if coordinate.friends == []
      coordinate.friends = get_neighbor_coordinates(game, coordinate)
    end
  end
end
