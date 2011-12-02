require 'user'

describe User do
  it "knows its name" do
    User.new(name: "joe").name.should == "joe"
  end

  it "allows adding a mention" do
    User.new.add_mention("joe")
  end

  it "knows who it has mentioned" do
    u = User.new
    u.add_mention("joe")
    u.mentions.include?("joe").should be_true
  end

  it "prevents duplicate mentions" do
    u = User.new
    u.add_mention("joe")
    u.add_mention("joe")
    u.mentions.size.should == 1
  end
  
end
