# End-to-end testing to validate the results given in the "simple" set
# of test data.
require 'utils'
require 'rules/rulebook'

describe "simple moves" do
  def test_file(filename)
    File.join(File.dirname(__FILE__), "data", filename)
  end
  
  it "validates all simple moves" do
    verbose = false
    
    board = Utils.load_board(test_file("simple_board.txt"))
    movements = Utils.load_movements(test_file("simple_moves.txt"))
    results = Utils.load_results(test_file("simple_results.txt"))

    if verbose
      movements.each_with_index do |movement, idx|
        move = Move.new(movement, board.piece_at(movement.from), board)
        puts "Test #{idx + 1} of #{results.size}"
        puts "Board: "
        puts board.to_s
        puts "Validating move #{move}"
        expected = results[idx]
        result = Rulebook.move_validator_for(move).valid?
        puts "Expecting: #{expected}"
        puts "Result: #{result}"
        raise "FAIL!" unless result == expected
      end
    else
      movements.map do |movement|
        move = Move.new(movement, board.piece_at(movement.from), board)
        Rulebook.move_validator_for(move).valid?
      end.should == results
    end
  end
end
