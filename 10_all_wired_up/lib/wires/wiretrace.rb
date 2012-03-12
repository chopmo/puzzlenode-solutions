module Wires
  class WireTrace
    attr_reader :target

    def initialize(start_cell, direction)
      @start_cell = start_cell
      @direction = direction
      trace
    end

    private
    def trace
      cell = @start_cell
      loop do
        next_cell = find_next_cell(cell)
        case next_cell
        when nil
          change_direction
        when Wire
          cell = next_cell
        else
          # We're at the target
          @target = next_cell
          break
        end
      end
    end

    def find_next_cell(cell)
      cell.send(@direction.to_s)
    end

    def change_direction
      unless [:up, :down].include?(@direction)
        fail "Can't change direction unless going up or down"
      end
      
      @direction = :left
    end

  end
end
