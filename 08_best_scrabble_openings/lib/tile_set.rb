require 'json'
require 'tile'

class TileSet
  def self.from_json(json)
    new(json)
  end

  def initialize(json)
    tile_strings = JSON.parse(json)
    tiles = tile_strings.map { |s| Tile.new(s) }
    @counts = Hash.new(0)
    tiles.each do |t|
      @counts[t.letter] += 1
    end
  end

  def count(letter)
    @counts[letter]
  end

end
