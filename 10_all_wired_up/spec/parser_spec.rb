require 'minitest/spec'
require 'minitest/autorun'

require 'wires/parser'

describe Wires::Parser do

  before do
    # Note: Leading whitespace is OK
    @diagram = <<-END
      0-------------|
                    |
                    O-----------@
      1-------------|
      END

  end

  it "can parse a simple diagram without errors" do
    Wires::Parser.new(@diagram)
  end
end
