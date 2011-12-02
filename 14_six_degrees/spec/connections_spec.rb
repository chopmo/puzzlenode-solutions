require 'input_parser'
require 'user_repository'
require 'connections'

describe Connections do
  let (:repo) do
    user_hash = InputParser.new(open(File.join(File.dirname(__FILE__), "../data/sample_input.txt")).read).parse
    UserRepository.new(user_hash.values)
  end

  let (:connections) { Connections.new(repo)  }
  
  it "finds first order connections" do
    connections.for("alberta", 1).sort.should == %w( bob christie )
    connections.for("bob", 1).sort.should == %w( alberta christie duncan )
  end
end
