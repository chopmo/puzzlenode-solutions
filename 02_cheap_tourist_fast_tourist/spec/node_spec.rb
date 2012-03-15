require 'graph'
require 'flight'

describe Graph::Node do
  it "finds the complete route" do
    n1 = Graph::Node.new()
    n2 = Graph::Node.new(Flight.new)
    n2.previous = n1
    n3 = Graph::Node.new(Flight.new)
    n3.previous = n2

    n1.route.flights.should == [n1.flight]
    n2.route.flights.should == [n1.flight, n2.flight]
    n3.route.flights.should == [n1.flight, n2.flight, n3.flight]
  end
end
