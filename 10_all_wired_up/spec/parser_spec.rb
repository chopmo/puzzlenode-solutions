minitest 'require/spec'
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

    @parser = Wires::Parser.new(@diagram)
  end


  it "finds the indent size" do
    @parser.indent_size.should == 6
  end
  
  
  it "finds the root nodes" do
    @parser.root_nodes.should == [[6,0], [6,3]]
  end
end
