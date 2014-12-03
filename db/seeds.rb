class DictionarySeeder
 def initialize(file)
    @file = File.open(file)
    @hard = ['x','y','z','q']
    @easy = ['a','e','i','o','u']
  end

  def cleanfile
    @file.readlines.map {|word| word.chomp}
  end

  def seed
    cleanfile.each {|word| DictionaryWord.create(word: word.downcase, points: score_word(word)); p word}
  end

  def score_word(word)
    letter_points = word.downcase.chars.map {|char| @hard.include?(char) ? 3 : @easy.include?(char) ? 1 : 2}
    letter_points.inject(:+)
  end
end

DictionarySeeder.new('public/dictionary').seed
