require 'stacker/contexts/context'
require 'stacker/contexts/if_statement'
require 'stacker/contexts/times_statement'

module Stacker
  module Contexts
    class Root < Context
      def execute(cmd)
        command = cmd.split.first
        args = cmd.split.drop(1)

        method = command_map[command]
        if method
          send(method.to_s, *args)
        else
          push_literal(cmd)
        end
      end
        
      def command_map
        {
          "<" => :less_than,
          ">" => :greater_than,
          "=" => :equals,
          "IF" => :if,
          "ADD" => :add,
          "SUBTRACT" => :subtract,
          "MULTIPLY" => :multiply,
          "DIVIDE" => :divide,
          "MOD" => :mod,
          "TIMES" => :times
        }
      end
      
      def push_literal(cmd)
        push(eval(cmd))
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

      def less_than
        b, a = pop, pop
        push a < b ? :true : :false
      end

      def greater_than
        b, a = pop, pop
        push a > b ? :true : :false
      end

      def equals
        push pop == pop ? :true : :false
      end

      def if
        IfStatement.create(@interpreter)
      end

      def times
        TimesStatement.create(@interpreter)
      end
    end
  end
end
