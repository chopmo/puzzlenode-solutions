require 'test_case_parser'

describe TestCaseParser do
  it "parses a test case" do
    input =<<END
3
A B 09:00 10:00 100.00
B Z 11:30 13:30 100.00
A Z 10:00 12:00 300.00
END
    testcase = TestCaseParser.parse(input)
    testcase.should be_a TestCase

    testcase.flights.size.should == 3

    f = testcase.flights.first
    f.from_city.should == "A"
    f.to_city.should == "B"
    f.departs.should == "09:00"
    f.arrives.should == "10:00"
    f.price.should == "100.00"
  end
end
