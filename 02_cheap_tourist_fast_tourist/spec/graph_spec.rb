require 'graph'
require 'test_case_parser'

describe Graph do
  it "constructs itself from a list of flights" do
#     input=<<END
# A B 09:00 10:00 100.00
# B Z 11:30 13:30 100.00
# A Z 10:00 12:00 300.00
# END

    input =<<END
A B 08:00 09:00 50.00
A B 12:00 13:00 300.00
A C 14:00 15:30 175.00
B C 10:00 11:00 75.00
B Z 15:00 16:30 250.00
C B 15:45 16:45 50.00
C Z 16:00 19:00 100.00
END

    flights = input.lines.map { |l| TestCaseParser.parse_flight(l) }
    # flights.each do |f|
    #   puts f
    # end

    g = Graph.build(flights)
    puts g
  end

# multiple trees, one per root node (source city)
# OR (more elegant)
# Pseudo root node with actual roots as connections
end
