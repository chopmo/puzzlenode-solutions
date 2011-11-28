require 'parsers/turn_parser'

describe TurnParser do
  def parse_turns(text)
    TurnParser.new(text).parse
  end
  
  it "parses a single line into a Turn instance" do
    turns = parse_turns("Rocky +QH +KD +8S +9C")
    turns.size.should == 1
    t = turns.first
    t.actions.size.should == 4
    t.player.should == "Rocky"
  end

  it "ignores comments" do
    turns = parse_turns("Rocky +QH +KD +8S +9C # foo!")
    turns.size.should == 1
    t = turns.first
    t.actions.size.should == 4
    t.player.should == "Rocky"
  end

  it "ignores blank and comment_only lines" do
    s =<<END
Rocky +QH +KD +8S +9C # foo!
# FOO

END
    turns = parse_turns(s)
    turns.size.should == 1
    t = turns.first
    t.actions.size.should == 4
    t.player.should == "Rocky"
  end

  it "adds signals to a turn" do
    turn_text =<<END
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
END
    turns = parse_turns(turn_text)
    turns.size.should == 1
    turns[0].signals.size.should == 3
  end
end
