require 'stacker/contexts/context'
require 'stacker/contexts/if_statement'
require 'stacker/contexts/times_statement'
require 'stacker/contexts/procedure'

module Stacker
  module Contexts
    class Root < Context
      def initialize(interpreter)
        super(interpreter)
        @procedures = {}
      end

      def execute(cmd)
        if command = command_map[cmd.split.first]
          args = cmd.split.drop(1)
          send(command.to_s, *args)
        elsif @procedures.keys.include?(cmd)
          call_procedure(cmd)
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
          "TIMES" => :times,
          "PROCEDURE" => :define_procedure,
          "DUP" => :dup,
          "SWAP" => :swap,
          "DROP" => :drop,
          "ROT" => :rot
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

      def define_procedure(name)
        @procedures[name] = Procedure.create(@interpreter)
      end

      def call_procedure(name)
        @procedures[name].run
      end

      def dup
        x = pop
        2.times do
          push x
        end
      end

      def swap
        a, b = pop, pop
        push a; push b
      end

      def drop
        pop
      end

      def rot
        one, two, three = pop, pop, pop
        push two
        push one
        push three
      end
    end

  end
end
