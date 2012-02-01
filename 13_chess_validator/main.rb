$:.unshift 'lib'
require 'utils'

board = Utils.load_board("spec/data/complex_board.txt")
movements = Utils.load_movements("spec/data/complex_moves.txt")
movements.each do |movement|
  move = Move.new(movement, board.piece_at(movement.from), board)
  puts Rulebook.move_validator_for(move).valid? ? "LEGAL" : "ILLEGAL"
end
