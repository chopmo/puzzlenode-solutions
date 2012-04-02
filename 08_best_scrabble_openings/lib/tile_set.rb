require 'json'
require 'tile'

class TileSet
  def self.from_json(json)
    new(json)
  end

  def initialize(json)
    tile_strings = JSON.parse(json)
    tiles = tile_strings.map { |s| Tile.new(s) }
    @letter_counts = Hash.new(0)
    tiles.each do |t|
      @letter_counts[t.letter] += 1
    end
  end

  # def count_letters(letters)

  # end
  
  def count(letter)
    @letter_counts[letter]
  end

  def can_form?(word)
    # letters = count_letters(word.split(//))
    false
  end

end
