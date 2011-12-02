require 'user'
require 'user_repository'
require 'input_parser'

describe UserRepository do
  let(:repo) { UserRepository.new }

  it "can be initialized with a list of users" do
    text = open(File.join(File.dirname(__FILE__), "..", "data", "sample_input.txt")).read
    user_hash = InputParser.new(text).parse
    UserRepository.new(user_hash.values).find_user("christie").should_not be_nil
  end

  it "supports adding users" do
    repo.add_user(User.new)
  end

  it "supports finding users by name" do
    joe = User.new(name: "joe")
    repo.add_user(joe)
    repo.find_user("joe").should == joe
  end

  it "returns nil unless user was found" do
    repo.find_user("joe").should be_nil
  end

end
