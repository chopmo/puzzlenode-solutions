require 'json'

class Board
  def self.from_json(json)
    Board.new(json)
  end


  def initialize(json)
    @cells = JSON.parse(json).map { |row| row.split(" ").map(&:to_i) }
  end

  def cell(r, c)
    @cells[r][c]
  end

  def score(placement)
    tiles = placement.tiles
    cells = remaining_cells(placement)
    tiles.zip(cells).map { |t, c| c * t.value }.inject(&:+)
  end

  def remaining_cells(p)
    if p.orientation == :horizontal
      @cells[p.row][p.column..-1]
    else
      @cells.transpose[p.column][p.row..-1]
    end
  end

end
