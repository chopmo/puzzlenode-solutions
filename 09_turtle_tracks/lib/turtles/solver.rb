require 'turtles/canvas'
require 'turtles/interpreter'

module Turtles
  class Solver
    def initialize(filename)
      @input_lines = File.readlines(filename)
      @interpreter = Interpreter.new(command_lines)
    end

    def canvas_size
      @input_lines.first.to_i
    end

    def command_lines
      @input_lines.drop(2)
    end

    def run
      @canvas = Canvas.new(canvas_size)
      # puts "Resulting canvas:"
      # puts @canvas.to_s

      while cmd = @interpreter.read_command
        puts cmd
      end
    end
  end
end
