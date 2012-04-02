require 'json'

class Board
  def self.from_json(json)
    cells = JSON.parse(json).map { |row| row.split(" ").map(&:to_i) }
    Board.new(cells)
  end

  def self.from_ascii(ascii)
    cells = ascii.gsub(/^$/, '').lines.map(&:strip).reject(&:empty?).map { |row| row.split(" ").map(&:to_i) }
    Board.new(cells)
  end

  def initialize(cells)
    @cells = cells
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
