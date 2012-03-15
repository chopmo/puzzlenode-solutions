require 'graph'
require 'test_case_parser'

describe Graph do

  let (:input) { <<END
A B 08:00 09:00 50.00
A B 12:00 13:00 300.00
A C 14:00 15:30 175.00
B C 10:00 11:00 75.00
B Z 15:00 16:30 250.00
C B 15:45 16:45 50.00
C Z 16:00 19:00 100.00
END
  }

  let (:flights) {
    input.lines.map { |l| TestCaseParser.parse_flight(l) }
  }    
  
  it "constructs itself from a list of flights" do
    g = Graph.build(flights)
    g.nodes.size.should > 0
  end

  # it "finds all routes to a city" do
  #   g.routes_to("Z").size.should == 4
  # end
  
  # it "finds the cheapest trip" do
  #   g = Graph.build(flights)
  #   puts g
  #   trip = g.cheapest_trip
  #   trip.departs.should == "09:00"
  #   trip.arrives.should == "13:30"
  #   trip.price.should == "200.00"
  # end

  # multiple trees, one per root node (source city)
  # OR (more elegant)
  # Pseudo root node with actual roots as connections
end
