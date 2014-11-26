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
    cleanfile.each {|word| DictionaryWord.create(word: word.downcase, points: score_word(word)); p wordqu}
  end

  def score_word(word)
    points = 0
    word.downcase.chars.each do |char|
      if @hard.include?(char)
        points += 3
      elsif @easy.include?(char)
        points +=1
      else
        points += 2
      end
    end
    points
  end
end

DictionarySeeder.new('/usr/share/dict/words').seed
