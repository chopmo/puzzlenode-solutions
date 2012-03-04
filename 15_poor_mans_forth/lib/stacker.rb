module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
    end

    def execute(cmd)
      if %(ADD SUBTRACT MULTIPLY DIVIDE MOD <).include?(cmd)
        send(cmd.downcase)
      else
        push(cmd.to_i)
      end
      # puts "After #{cmd}, stack is #{stack}"
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

    def mod
      b, a = pop, pop
      push a % b
    end

    def <
      b, a = pop, pop
      push a < b ? :true : :false
    end
    private 

    # XXX: use delegation
    def push(e)
      stack.push(e)
    end

    def pop
      stack.pop
    end
  end
end
