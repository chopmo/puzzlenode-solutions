require 'placement'
require 'tile'

describe Placement do
  before do
    @tile = Tile.new("l3")
    @placement = Placement.new(1, 2, :vertical, [@tile])
  end

  it "has getters for row, column, orientation and tiles" do
    @placement.row.should == 1
    @placement.column.should == 2
    @placement.orientation.should == :vertical
    @placement.tiles.should == [@tile]
  end

end
