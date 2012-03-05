require 'stacker/contexts/context'

module Stacker
  module Contexts
    class IfStatement < Context
      def self.create(interpreter)
        interpreter.push_context(new(interpreter))
      end

      def initialize(interpreter)
        super
        @is_true = (pop == :true)
        @in_else_block = false
      end

      def execute(cmd)
        case cmd
        when /ELSE/ then enter_else
        when /THEN/ then finish
        else
          parent_context.execute(cmd) 
        end
      end

      def enter_else
        @in_else_block = true
      end

      def finish
        @interpreter.pop_context
      end

      def active?
        @in_else_block != @is_true
      end
    end
  end
end
