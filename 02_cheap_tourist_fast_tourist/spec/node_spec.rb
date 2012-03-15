require 'graph'
require 'flight'

describe Graph::Node do
  it "finds the complete route" do
    f1 = Flight.new("A", "B", nil, nil, nil)
    f2 = Flight.new("B", "C", nil, nil, nil)
    f3 = Flight.new("C", "D", nil, nil, nil)
    n1 = Graph::Node.new(f1)
    n2 = Graph::Node.new(f2)
    n2.previous = n1
    n3 = Graph::Node.new(f3)
    n3.previous = n2

    n1.route.flights.should == [n1.flight]
    n2.route.flights.should == [n1.flight, n2.flight]
    n3.route.flights.should == [n1.flight, n2.flight, n3.flight]
  end

  it "disregards a dummy start node" do
    f1 = Flight.new("-", "A", nil, nil, nil)
    f2 = Flight.new("A", "B", nil, nil, nil)
    n1 = Graph::Node.new(f1)
    n2 = Graph::Node.new(f2)
    n2.previous = n1

    n2.route.flights.should == [n2.flight]
  end
end
