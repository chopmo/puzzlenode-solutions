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

  it "finds all routes to a city" do
    g = Graph.build(flights)
    g.routes_to("Z").size.should == 4
  end

  it "finds the cheapest route" do
    g = Graph.build(flights)

    route = g.cheapest_route
    route.departs.should == "08:00"
    route.arrives.should == "19:00"
    route.formatted_price.should == "225.00"
  end

  it "finds the fastest route" do
    g = Graph.build(flights)

    route = g.fastest_route
    route.departs.should == "12:00"
    route.arrives.should == "16:30"
    route.formatted_price.should == "550.00"
  end
end
