require 'puzzle'

require 'digest/sha1'

describe Puzzle do
  it "comes up with the right solution" do
    text = open(File.join(File.dirname(__FILE__), "..", "data", "complex_input.txt"), "r:UTF-8").read
    result_text = Puzzle.new(text).solve
    Digest::SHA1.hexdigest(result_text).should == "decd82183ce9a6b15c3c8b1a413a79b65f106fb0"
  end
end


