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
      # puts "Executing #{cmd}"
      cmd = cmd.strip
      return if cmd.empty?
      return if cmd.index("#") == 0
      @contexts.last.execute(cmd)
      # puts "After executing %15s: #{stack}" % cmd
    end

    def push_context(ctx)
      @contexts.push(ctx)
    end

    def pop_context
      @contexts.pop
    end

    def add_procedure(name, procedure)
      root_context.add_procedure(name, procedure)
    end

    def root_context
      @contexts.first
    end

    def parent_context_of(child)
      child_idx = @contexts.rindex(child)
      parent_idx = child_idx - 1
      if parent_idx < 0
        raise "Parent context of #{child} not found"
      end
      @contexts[parent_idx]
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

    def active?
      @contexts.all?(&:active?)
    end
  end
end
