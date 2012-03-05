module Stacker
  module Contexts
    class Context
      def initialize(interpreter)
        @interpreter = interpreter
      end

      def parent_context
        @interpreter.parent_context_of(self)
      end

      def push(x)
        @interpreter.stack.push(x)
      end

      def pop
        @interpreter.stack.pop
      end
    end
  end
end
