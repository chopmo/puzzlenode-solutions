module Stacker
  module Contexts
    class Context
      def initialize(interpreter)
        @interpreter = interpreter
      end

      def root_context
        @interpreter.root_context
      end

      def push(x)
        @interpreter.push(x)
      end

      def pop
        @interpreter.pop
      end

      def active?
        true
      end
    end
  end
end
