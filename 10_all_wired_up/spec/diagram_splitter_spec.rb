require 'wires/diagram_splitter'

module Wires
  describe DiagramSplitter do
    it "splits a file with diagrams on a blank" do
      ascii_diagram =<<END
0-------------|
              |
              O-----------@
1-------------|

0-------------|
              A------------|
1-------------|            |
                           X------------@
1-------------|            |
              N------------|

0-------------|
              O------------|
1-------------|            |
                           X------------@
1-------------|            |
              X------------|
1-------------|
END

      fragments = DiagramSplitter.split(ascii_diagram)
      fragments.size.should == 3
      fragments[0].lines.to_a.size.should == 4
      fragments[1].lines.to_a.size.should == 6
      fragments[2].lines.to_a.size.should == 7
    end
  end
end
