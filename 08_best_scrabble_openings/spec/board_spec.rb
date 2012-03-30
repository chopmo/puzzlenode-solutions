require 'board'

describe Board do
  context "given a JSON representation" do
    before do
      json =<<END
[
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 1 1 1 3 1 1 1 1 2 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"
  ]
END
      @board = Board.from_json(json)
    end
    
    it "creates a new instance" do
      @board.should_not be_nil
    end

    it "splits the board into cells" do
      @board.cell(3, 0).should == 2
      @board.cell(2, 1).should == 2
      @board.cell(2, 2).should == 1
    end
  end
  
  context "given a placement" do
    it "returns the score"
  end
end
