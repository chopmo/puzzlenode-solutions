require 'table'
require 'parsers/turn_parser'

describe Table do
  before(:each) do
    @table = Table.new
  end

  def apply(s)
    @table = @table.apply(TurnParser.new(s).parse.first)
  end
  
  it 'correctly applies a draw from the pile' do
    apply("Rocky +5S").hands["Rocky"].should == ["5S"]
  end

  it 'correctly applies a discard' do
    apply("Rocky +5S")
    apply("Rocky -5S:discard")
    @table.hands["Rocky"].should be_empty
    @table.discards.should == ["5S"]
  end
  
  it 'correctly applies sending a card' do
    apply("Rocky +5S")
    apply("Rocky -5S:Lil")
    @table.hands["Rocky"].should be_empty
    @table.hands["Lil"].should be_empty
    @table.transit.should == ["5S"]
  end

  it 'correctly applies receiving a card' do
    apply("Rocky +5S")
    apply("Rocky -5S:Lil")
    apply("Lil +5S:Rocky")
    @table.hands["Rocky"].should be_empty
    @table.hands["Lil"].should == ["5S"]
    @table.transit.should be_empty
  end

  it 'returns the new state after applying a turn' do
    orig = @table
    apply("Rocky +5S").hands["Rocky"].should == ["5S"]
    orig.hands.should be_empty
  end

  it 'detects if a card enters the game twice' do
    apply("Rocky +5S")
    apply("Lil +5S").should be_nil
  end
end
