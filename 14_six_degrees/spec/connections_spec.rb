require 'input_parser'
require 'user_repository'
require 'connections'

describe Connections do
  let (:repo) do
    user_hash = InputParser.new(open(File.join(File.dirname(__FILE__), "../data/sample_input.txt")).read).parse
    UserRepository.new(user_hash.values)
  end

  it "finds first order connections" do
    Connections.new(repo, "alberta").on_level(1).sort.should == %w( bob christie )
    Connections.new(repo, "bob").on_level(1).sort.should == %w( alberta christie duncan )
  end

  it "finds second order connections" do
    # connections.for("alberta", 2).sort.should == %w( duncan emily )
    # connections.for("bob", 2).sort.should == %w( emily farid )
  end
end
