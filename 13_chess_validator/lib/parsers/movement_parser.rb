require 'model/movement'

class MovementParser
  def initialize(text)
    @text = text
  end

  def parse
    @text.lines.map(&:strip).map do |l|
      positions = l.split(/ /)
      positions.size == 2 ? Movement.new(positions[0], positions[1]) : nil
    end.compact
  end
end
