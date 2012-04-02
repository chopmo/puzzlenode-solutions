require 'json'
require 'board'
require 'dictionary'
require 'tile_set'

class Solver
  def self.solve(input)
    input_hash = JSON.parse(input)

    # XXX it's pretty silly to convert back to json here...objects
    # should just be constructable from the arrays.
    board = Board.from_json(input_hash["board"].to_json) 
    dictionary = Dictionary.from_json(input_hash["dictionary"].to_json)
    tileset = TileSet.from_json(input_hash["tiles"].to_json)

    dictionary.reject_unplacable(tileset)

    max_score = 0
    best_placement = nil
    
    dictionary.words.each do |word|
      tiles = tileset.get_tiles(word)
      placements = board.possible_placements(tiles)
      placements.each do |p|
        score = board.score(p)
        if score > max_score
          max_score = score
          best_placement = p
        end
      end
    end

    board.render(best_placement)
  end
end
