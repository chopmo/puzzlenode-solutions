require 'stacker/contexts/context'

module Stacker
  module Contexts
    class IfStatement < Context
      def self.create(interpreter)
        interpreter.push_context(new(interpreter))
      end

      def initialize(interpreter)
        super
        @is_true = (pop == ":true")
      end

      def execute(cmd)
        case cmd
        when /ELSE/ then enter_else
        when /THEN/ then finish
        else
          if @is_true != @in_else_block
            parent_context.execute(cmd) 
          end
        end
      end

      def enter_else
        @in_else_block = true
      end

      def finish
        @interpreter.pop_context
      end
    end
  end
end
