require 'action'

describe Action do
  it "knows if it is unresolved" do
    Action.new(action_type: "-", player: "Shady").should be_unresolved
  end

  it "knows if it is resolved" do
    Action.new(action_type: "-", player: "Shady", card: "AH").should_not be_unresolved
  end

  it "can resolve itself with another action" do
    action = Action.new(action_type: "-", player: "Shady")
    resolved_action = action.resolve_with(Action.new(action_type: "-", player: "Shady", card: "AH"))
    resolved_action.card.should == "AH"
  end

  it "can be compared to another action for equality" do
    a1 = Action.new(action_type: "-", player: "Shady", card: "AH")
    a2 = Action.new(action_type: "-", player: "Shady", card: "AH")
    a1.should == a2
  end
end
