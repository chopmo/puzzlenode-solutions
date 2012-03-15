require 'graph'
require 'flight'

describe Graph::Route do
  let (:route) {
    Graph::Route.new([Flight.new("A", "B", "08:00", "10:00", "20.00"),
                      Flight.new("B", "C", "12:00", "12:45", "30.00")])
  }

  it "knows its from_city" do
    route.from_city.should == "A"
  end

  it "knows its to_city" do
    route.to_city.should == "C"
  end

  it "knows its depart time" do
    route.departs.should == "08:00"
  end

  it "knows its arrival time" do
    route.arrives.should == "12:45"
  end

  it "knows its duration" do
    route.formatted_duration.should == "04:45"
  end

  it "knows its price" do
    route.formatted_price.should == "50.00"
  end

  it "knows the result format" do
    route.result_format.should == "08:00 12:45 50.00"
  end
end
