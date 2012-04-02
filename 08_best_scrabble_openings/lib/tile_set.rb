require 'json'
require 'tile'

class TileSet
  def self.from_json(json)
    tiles = JSON.parse(json).map { |s| Tile.new(s) }
    new(tiles)
  end

  def initialize(tiles)
    @tiles = tiles
    @letter_counts = count_letters(@tiles.map(&:letter))
  end

  def count_letters(letters)
    # XXX there is an easier way
    res = Hash.new(0)
    letters.each do |l|
      res[l] += 1
    end
    res
  end
  
  def count(letter)
    @letter_counts[letter]
  end

  def can_form?(word)
    count_letters(word.split(//)).all? { |k, v| @letter_counts[k] >= v }
  end

  def get_tiles(word)
    word.split(//).map { |l| get(l) }
  end

  private
  def get(letter)
    @tiles.select { |t| t.letter == letter }.first
  end


end
