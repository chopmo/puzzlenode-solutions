module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
    end

    def execute(cmd)
      case cmd
      when /ADD/ then add
      else 
        # Assume it's an integer
        push(cmd.to_i)
      end
    end

    def add
      push(pop + pop)
    end

    def push(e)
      stack.unshift(e)
    end

    def pop
      stack.shift
    end
  end
end