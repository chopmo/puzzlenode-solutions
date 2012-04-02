class Placement < Struct.new(:row, :column, :orientation, :tiles)
  def to_s
    "[#{row},#{column}] '#{tiles.map(&:letter).join}' #{orientation}"
  end

end
