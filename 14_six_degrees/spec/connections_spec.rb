require 'input_parser'
require 'user_repository'
require 'connections'

describe Connections do
  let (:repo) do
    repo = InputParser.new(open(File.join(File.dirname(__FILE__), "../data/sample_input.txt")).read).parse
  end

  it "finds first order connections" do
    Connections.new(repo, "alberta").on_level(1).sort.should == %w( bob christie )
  end

  it "can find all connections to a certain depth" do
    Connections.new(repo, "alberta").all(2).sort.should == %w( bob christie duncan emily )
  end
  
  it "finds second order connections" do
    Connections.new(repo, "alberta").on_level(2).sort.should == %w( duncan emily )
  end

  it "finds third order connections" do
    Connections.new(repo, "alberta").on_level(3).sort.should == %w( farid )
  end

  it "finds fourth order connections" do
    Connections.new(repo, "alberta").on_level(4).sort.should == %w( )
  end
end
