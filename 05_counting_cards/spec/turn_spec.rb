require 'turn'
require 'parsers/turn_parser'

describe Turn do
  it "knows if it is resolved" do
    Turn.new(actions: [mock]).should be_resolved
  end

  it "knows if it is unresolved" do
    Turn.new(actions: [mock], signals: [mock]).should_not be_resolved
  end

  it "can resolve itself" do
    turn_text =<<END
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
END
    turn = TurnParser.new(turn_text).parse[0]
    turn.resolutions.size.should == 3
    turn.resolutions[0].should == TurnParser.new("Lil +JC:Rocky +JH -7C:Shady +10C").parse.first
    turn.resolutions[1].should == TurnParser.new("Lil +JC:Rocky +JH -8D:Shady +9S").parse.first
    turn.resolutions[2].should == TurnParser.new("Lil +JC:Rocky +JH -8D:Shady +10C").parse.first
  end

  it "can be compared for equality to another turn" do
    t1 = TurnParser.new("Lil +JC:Rocky +JH -7C:Shady +10C").parse.first    
    t2 = TurnParser.new("Lil +JC:Rocky +JH -7C:Shady +10C").parse.first
    t1.should == t2
  end
end
