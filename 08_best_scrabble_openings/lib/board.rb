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

  def rows
    @cells
  end

  def columns
    @cells.transpose
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

  def size
    @cells.size
  end

  def valid_placement?(p)
    remaining_cells(p).size >= p.tiles.size
  end

  def possible_placements(tiles)
    res = []
    size.times do |row_idx|
      size.times do |col_idx|
        [:horizontal, :vertical].each do |orientation|
          p = Placement.new(row_idx, col_idx, orientation, tiles)
          res << p if valid_placement?(p)
        end
      end
    end
    res
  end

  def render(placement)
    canvas = @cells.dup
    row = placement.row
    column = placement.column
    placement.tiles.each do |t|
      canvas[row][column] = t.letter
      if placement.orientation == :horizontal
        column += 1
      else
        row += 1
      end
    end

    canvas.map { |row| row.join }.join("\n") + "\n"
  end

end
