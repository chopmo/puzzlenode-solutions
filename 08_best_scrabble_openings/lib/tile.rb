class Tile
  def initialize(s)
    @letter = s[0]
    @value = s[1].to_i
  end

  attr_reader :letter, :value
end
