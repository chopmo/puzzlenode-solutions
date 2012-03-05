require 'stacker/contexts'

module Stacker
  class Interpreter
    attr_reader :stack

    def initialize
      @stack = []
      @full_stack = []
      @contexts = [Contexts::Root.new(self)]
    end

    def execute(cmd)
      @contexts.last.execute(cmd)
      # if active?
      #   puts "After executing #{cmd}: #{stack}"
      # end
    end

    def push_context(ctx)
      @contexts.push(ctx)
    end

    def pop_context
      @contexts.pop
    end

    def root_context
      @contexts.first
    end

    def push(x)
      @stack.push(x) if active?
      @full_stack.push(x)
    end

    def pop
      x = @full_stack.pop
      x = @stack.pop if active?
      x
    end

    private 

    def active?
      @contexts.all?(&:active?)
    end
  end
end
