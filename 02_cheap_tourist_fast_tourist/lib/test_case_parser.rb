require 'test_case'
require 'flight'

class TestCaseParser
  def self.parse(input)
    flights = input.lines.drop(1).map { |l| parse_flight(l) }
    TestCase.new(flights)
  end

  def self.parse_flight(line)
    Flight.new(*line.split)
  end
end
