require 'graph'

class Solver
  def self.solve(test_cases)
    test_cases.map { |tc|
      g = Graph.build(tc.flights)
      "#{g.cheapest_route.result_format}\n#{g.fastest_route.result_format}\n"
    }.join("\n")
  end

end
