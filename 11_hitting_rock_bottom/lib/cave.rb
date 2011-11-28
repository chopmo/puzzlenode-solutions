class Cave
  def initialize(tiles)
    @tiles = tiles
    @tip = find_tip
    @water_units = 1
  end

  def find_tip
    @tiles.each_with_index { |r, r_idx| r.each_with_index { |c, c_idx| return [r_idx, c_idx] if c == "~" } }
  end

  def add_water
    if air?(below(@tip))
      fall
    elsif rock?(to_the_right_of(@tip))
      backtrack
    else
      go_right
    end
  end

  def above(p)
    [p[0]-1, p[1]]
  end

  def below(p)
    [p[0]+1, p[1]]
  end

  def to_the_right_of(p)
    [p[0], p[1]+1]
  end

  def to_the_left_of(p)
    [p[0], p[1]-1]
  end

  def air; " "; end
  def water; "~"; end
  def rock; "#"; end

  def air?(p); tile_at(p) == air; end
  def rock?(p); tile_at(p) == rock; end
  def water?(p); tile_at(p) == water; end

  def tile_at(p)
    @tiles[p[0]][p[1]]
  end

  def fall
    @tip = below(@tip)
    fill_tip
  end

  def backtrack
    @tip = to_the_left_of(@tip) while air?(above(@tip))
    @tip = above(to_the_right_of(@tip))
    fill_tip
  end

  def go_right
    @tip = to_the_right_of(@tip)
    fill_tip
  end

  def fill_tip
    tile_at(@tip).replace(water)
    @water_units += 1
  end

  def water_level_at(col)
    water_level = 0
    @tiles.each_with_index do |row, row_no|
      if water?([row_no, col])
        water_level += 1
      elsif water_level > 0 && air?([row_no, col])
        return water # Edge case, this is where we return "~" because water is falling here. 
      end
    end
    water_level
  end

  def result_string
    (0...@tiles.first.size).map { |col| water_level_at(col).to_s }.join(" ")
  end

  def to_s
    out = ""
    @tiles.each_with_index do |row, idx|
      out += sprintf("%3d", idx) + "  "
      out += row.join("  ")
      out += "\n\n"
    end
    out += "   "
    out += (0...(@tiles.first.size)).map { |col| sprintf("%3d", col) }.join
    out += "\n\nWater level:\n"
    out += "   "
    out += (0...(@tiles.first.size)).map do |col|
      level = water_level_at(col)
      level == water ? "  ~" : sprintf("%3d", level)
    end.join
    out += "\n\n"
    out += "Tip is at #{@tip}\n"
    out += "#{@water_units} water units\n"
    out += "\n\nResult string: #{result_string}"
    out
  end
end
