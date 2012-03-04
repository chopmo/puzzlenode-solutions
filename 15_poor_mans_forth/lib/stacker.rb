module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
    end

    def execute(cmd)
      if %(ADD SUBTRACT MULTIPLY DIVIDE).include?(cmd)
        send(cmd.downcase)
      else
        push(cmd.to_i)
      end
    end

    def add
      push(pop + pop)
    end

    def subtract
      b, a = pop, pop
      push(a - b)
    end

    def multiply
      push(pop * pop)
    end

    def divide
      b, a = pop, pop
      push(a / b)
    end
    private 

    def push(e)
      stack.unshift(e)
    end

    def pop
      stack.shift
    end
  end
end
