require 'user'
require 'user_repository'

describe UserRepository do
  let(:repo) { UserRepository.new }
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
