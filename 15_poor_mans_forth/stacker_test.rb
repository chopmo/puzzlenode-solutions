
# the minitest gem and then uncomment the following line.
#
require 'rubygems'

require "minitest/autorun"

require 'stacker'

describe "Stacker::Interpreter" do

  let(:interpreter) { Stacker::Interpreter.new }

  it "implements ADD" do
    execute %w[
      2
      3
      ADD
    ]

    interpreter.stack.must_equal([5])
  end

  it "implements SUBTRACT command" do
    execute %w[
      1
      2
      SUBTRACT
    ]
    
    interpreter.stack.must_equal([-1])
  end
  
  it "implements MULTIPLY" do
    execute %w[
      3
      10
      MULTIPLY
    ]
    
    interpreter.stack.must_equal([30])
  end

  it "implements DIVIDE" do
    execute %w[
      6
      2
      DIVIDE
      ]
      
    interpreter.stack.must_equal([3])
  end
  
  it "implements MOD" do
    execute %w[
      4
      3
      MOD
      15
      3
      MOD
    ]
    
    interpreter.stack.must_equal([1,0])
  end
  
  it "implements <" do
    execute %w[
      3
      10
      <
      5
      4
      <
    ]

    interpreter.stack.must_equal([:true, :false])
  end
  
  it "implements >" do
    execute %w[
      3
      10
      >
      5
      4
      >
    ]
    
    interpreter.stack.must_equal([:false, :true])
  end

  it "implements =" do
    execute %w[
      1
      1
      =
      1
      2
      =
    ]

    interpreter.stack.must_equal([:true, :false])
  end
  
  it "implements the IF command" do
    execute %w[
      :true
      IF
      1
      2
      ADD
      ELSE
      5
      THEN
      2
      5
      MULTIPLY
    ]
    
    interpreter.stack.must_equal([3, 10])
  end
  
  it "implements the IF command in nesting" do
    execute %w[ 
       :true
       IF
       :false
       IF
       1
       ELSE
       2
       THEN
       3
       ELSE
       :true
       IF
       4
       ELSE
       5
       THEN
       6
       THEN
       7
     ]

    interpreter.stack.must_equal([2,3,7])
  end
  
  it "implements the IF command in another 2-level nesting" do
    execute %w[
      :false
      IF
      0
      :false
      IF
      1
      2
      ELSE
      3
      2
      2
      ADD
      THEN
      5
      2
      3
      MULTIPLY
      ELSE
      3
      4
      ADD
      7
      8
      <
      IF
      2
      4
      MULTIPLY
      3
      3
      MULTIPLY
      ELSE
      10
      11
      THEN
      12
      13
      THEN
      14
      15
    ]
    
    interpreter.stack.must_equal([7,8,9,12,13,14,15])
  end

  it "implements the IF command in 3-level nesting" do
    execute %w[
      :true
      IF
      :false
        IF
        :false
          IF
          1
          ELSE
          2
          THEN
          3
        ELSE
        :true
          IF
          4
          ELSE
          5
          THEN
          6
        THEN
        7
      ELSE
      :false
        IF
        :true
          IF
          8
          ELSE
          9
          THEN
          10
        ELSE
        :true
          IF
          11
          ELSE
          12
          THEN
          13
        THEN
        14
      THEN
      15
      ]
    interpreter.stack.must_equal([4,6,7,15])
  end

  it "implements TIMES command" do
    execute %w[
      5
      3
      TIMES
      1
      ADD
      /TIMES
    ]

    interpreter.stack.must_equal([8])
  end

  it "implements TIMES inside of IF command" do
    execute %w[
      :true
      IF
      5
      3
      TIMES
      2
      ADD
      /TIMES
      ELSE
      2
      4
      TIMES
      2
      MULTIPLY
      /TIMES
      THEN
      3
      5
      TIMES
      2
      ADD
      /TIMES
      ADD
    ]

    interpreter.stack.must_equal([24])
  end
  # 
  # it "implements IF inside of TIMES command" do
  #   execute %w[
  #     5
  #     3
  #     TIMES
  #     :true
  #     IF
  #     1
  #     ADD
  #     ELSE
  #     2
  #     ADD
  #     THEN
  #     3
  #     ADD
  #     /TIMES
  #   ]


  #   interpreter.stack.must_equal([17])
  # end

  # it "implements PROCEDURE command" do
  #   execute %w[
  #     PROCEDURE\ DOUBLE
  #     2
  #     MULTIPLY
  #     /PROCEDURE
  #     100
  #     DOUBLE
  #     DOUBLE
  #   ]

  #   interpreter.stack.must_equal([400])
  # end
  # 
  # it "implements DUP command" do
  #   execute %w[
  #     1
  #     2
  #     DUP
  #   ]
  #   
  #   interpreter.stack.must_equal([1,2,2])
  # end

  # it "implements SWAP command" do
  #   execute %w[
  #     1
  #     2
  #     SWAP
  #   ]
  #   
  #   interpreter.stack.must_equal([2,1])
  # end
  # 
  # it "implements DROP" do
  #   execute %w[
  #     1
  #     2
  #     DROP
  #   ]
  #   
  #   interpreter.stack.must_equal([1]) 
  # end
  # 
  # it "implements ROT" do
  #   execute %w[
  #     :foo
  #     :bar
  #     :baz
  #     :foobar
  #     :quux
  #     ROT
  #   ]
  #  
  #   # ROT takes the third element on the stack and places it on the
  #   # top of the stack, pushing the first and second element downwards
  #   interpreter.stack.must_equal([:foo,:bar,:foobar, :quux, :baz])
  # end

  # it "implements support for adding arbitrary symbols to the stack" do
  #   execute %w[
  #     :foo
  #     :bar
  #     :baz
  #   ]

  #   interpreter.stack.must_equal([:foo,:bar,:baz])
  # end

  def execute(commands)
    commands.each { |c| interpreter.execute(c) }
  end
  
end
