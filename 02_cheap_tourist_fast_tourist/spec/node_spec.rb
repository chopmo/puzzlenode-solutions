require 'graph'
require 'flight'

describe Graph::Node do
  it "finds the complete route" do
    n1 = Graph::Node.new(Flight.new)
    n2 = Graph::Node.new(Flight.new)
    n2.previous = n1
    n3 = Graph::Node.new(Flight.new)
    n3.previous = n2

    n1.route.should == [n1]
    n2.route.should == [n1, n2]
    n3.route.should == [n1, n2, n3]
  end
end
