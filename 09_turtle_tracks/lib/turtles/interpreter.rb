module Turtles
  class Interpreter
    def initialize(lines)
      @lines = lines
      @index = -1
      parse_input
    end

    def read_command
      return nil if @index >= @commands.size
      @index += 1
      @commands[@index]
    end

    private 

    def parse_input
      @commands = []
      @lines.map { |l| parse_line(l.strip) }
    end

    def parse_line(l)
      if l.index("REPEAT") == 0
        parse_repetition(l)
      else
        parse_simple_command(l)
      end
    end

    def parse_repetition(l)
      tokens = l.split

      tokens.shift # discard REPEAT
      count = tokens.shift.to_i
      tokens.shift # discard [
      tokens.pop   # discard ]

      count.times do
        idx = 0
        while idx < tokens.size
          parse_simple_command("#{tokens[idx]} #{tokens[idx+1]}")
          idx += 2
        end
      end
    end

    def parse_simple_command(cmd)
      @commands << cmd
    end
  end
end
