require 'simulation'
require 'table'

require 'parsers/turn_parser'

describe Simulation do
  def apply(s, applied_turns = [])
    turns = TurnParser.new(s).parse
    Simulation.apply_turn(Table.new, turns, 0, applied_turns)
  end

  it 'applies a valid turn to the table and returns the table' do
    table = apply("Rocky +5S +QH +6H +JC")
    table.hands["Rocky"].sort.should == %w{ 5S 6H JC QH }
  end

  it 'applies a valid sequence of turns to the table and returns the table' do
    turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +?? -??:Shady +??
END
    table = apply(turns_txt)
    table.hands["Shady"].should be_empty
    table.hands["Rocky"].sort.should == %w{ 2D 5S 6H QH }
    table.hands["Danny"].sort.should == %w{ 10D }
    table.hands["Lil"].sort.should == %w{ 3S 7C 8D 9H JC }
    table.discards.sort.should == %w{ 4D 4H 4S }
  end

  it 'keeps record of all applied turns' do
    turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
END

    applied_turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +JH -7C:Shady +10C
END

    applied_turns = []
    table = apply(turns_txt, applied_turns)
    applied_turns.should == TurnParser.new(applied_turns_txt).parse
  end


  it 'applies the first valid signal' do
    turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
END
    table = apply(turns_txt)
    table.hands["Shady"].should be_empty
    table.hands["Rocky"].sort.should == %w{ 2D 5S 6H QH }
    table.hands["Danny"].sort.should == %w{ 10D }
    table.hands["Lil"].sort.should == %w{ 10C 3S 8D 9H JC JH  }
    table.discards.sort.should == %w{ 4D 4H 4S }
  end


  it 'backtracks to choose another signal given more information' do
    turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C # This looks valid but...
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
Shady +??:Lil -8D:Rocky +??
Rocky +8D:Shady +9S -2D:discard -5S:Lil
Danny +?? -KS:discard -10D:discard +?? +??

# ...now we discover that she didn't send the 7C to Shady. 
# In signal 2 she gets the 9S which Rocky also gets a few lines down
# So signal 3 must be the correct one
Lil +5S:Rocky +?? -7C:discard -10C:discard -5S:discard  
END
    table = apply(turns_txt)
    table.hands["Shady"].sort.should == %w{ }
    table.hands["Rocky"].sort.should == %w{ 6H 8D 9S QH }
    table.hands["Danny"].sort.should == %w{ }
    table.hands["Lil"].sort.should == %w{ 3S 9H JC JH  }
    table.discards.sort.should == %w{ 10C 10D 2D 4D 4H 4S 5S 7C KS }
  end


  it 'solves the complete input' do
    turns_txt =<<END
Shady +?? +?? +?? +??
Rocky +5S +QH +6H +JC
Danny +?? +?? +?? +??
Lil +7C +3S +8D +9H
Shady -4H:discard -??:Danny +??
Rocky +10D -10D:Danny +4S +2D -4S:discard -JC:Lil
Danny +??:Shady +10D:Rocky +?? +?? +?? -4D:discard
Lil +JC:Rocky +?? -??:Shady +??
*  +JH -7C:Shady +10C
*  +JH -8D:Shady +9S
*  +JH -8D:Shady +10C
Shady +??:Lil -8D:Rocky +??
Rocky +8D:Shady +9S -2D:discard -5S:Lil
Danny +?? -KS:discard -10D:discard +?? +??
Lil +5S:Rocky +?? -7C:discard -10C:discard -5S:discard
* +KC
* +6S
* +9S
Shady -??:Lil +?? -??:Lil -??:Danny +??
Rocky +7D -9S:Shady -7D:discard -6H:Lil +2S -8D:Lil
Danny +??:Shady +?? -6C:discard -??:Lil -7S:discard -KD:discard -5C:discard
Lil +??:Shady +??:Shady +6H:Rocky +8D:Rocky +??:Danny -??:Danny +?? +??
* +2H:Shady +QC:Shady +3D:Danny -3S:Danny +JD +8S
* +3C:Shady +3D:Shady +10S:Danny -3C:Danny +AH +3H
* +QC:Shady +JD:Shady +10S:Danny -6S:Danny +7H +8H
Shady +9S:Rocky -9S:discard -QD:discard -10H:discard
Rocky +9D -9D:discard -2S:Lil
Danny +??:Lil -AD:discard +?? +?? +??
Lil +2S:Rocky +?? -??:Shady +?? -8D:discard
* +3D -9H:Shady +AH
* +3C -3C:Shady +AS
* +3D -2S:Shady +AS
Shady +??:Lil +?? -2S:Rocky -5H:discard -??:Danny
Rocky +2S:Shady +KC -KC:discard +2C
Danny +??:Shady +?? +?? -KH:discard +?? -9C:discard -4C:discard
Lil -9H:discard -JH:Rocky -JC:discard +?? -3D:discard
* +AS
* +3D
* +3C
END
    apply(turns_txt).should_not be_nil
  end
end
