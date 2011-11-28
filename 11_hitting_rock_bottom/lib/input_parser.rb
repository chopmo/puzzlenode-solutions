class InputParser
  def initialize(text)
    @lines = text.lines.map(&:strip)
  end

  def num_units
    @lines[0].to_i
  end

  def tiles
    @lines.drop(2).map do |l|
      l.chars.to_a
    end
  end
end
