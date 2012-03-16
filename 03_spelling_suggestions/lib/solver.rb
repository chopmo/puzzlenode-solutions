require 'word'

class Solver
  def self.solve(input)
    cases = input.split(/^\n/).drop(1)
    cases.map { |c|
      wrong, w1, w2 = *c.split(/\n/)
      Word.fix_spelling(wrong, w1, w2)
    }.join("\n") + "\n"
  end

end
