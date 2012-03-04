require 'stacker/stack_operations'

module Stacker
  class Arithmetic
    include StackOperations

    def initialize(data)
      @data = data
    end
    
    def execute(cmd)
      method_name = cmd.downcase
      send(method_name)
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

  end
end
