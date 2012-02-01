require 'input_parser'

describe InputParser do
  TEXT =<<END
alberta: @bob "It is remarkable, the character of the pleasure we derive from the best books."
bob: "They impress us ever with the conviction that one nature wrote and the same reads." /cc @alberta
alberta: hey @christie. what will we be reading at the book club meeting tonight?
christie: 'Every day, men and women, conversing, beholding and beholden.' /cc @alberta, @bob
bob: @duncan, @christie so I see it is Emerson tonight
duncan: We'll also discuss Emerson's friendship with Walt Whitman /cc @bob
alberta: @duncan, hope you're bringing those peanut butter chocolate cookies again :D
emily: Unfortunately, I won't be able to make it this time /cc @duncan
duncan: @emily, oh what a pity. I'll fill you in next week.
christie: @emily, "Books are the best of things, well used; abused, among the worst." -- Emerson
emily: Ain't that the truth ... /cc @christie
duncan: hey @farid, can you pick up some of those cookies on your way home?
farid: @duncan, might have to work late tonight, but I'll try and get away if I can
END

  let (:repo) { InputParser.new(TEXT).parse }

  it "parses a text of tweets into a user repository" do
    repo.users.size.should == 6
  end

  it "adds names to users" do
    repo.find_user("emily").should_not be_nil
  end

  it "records mentions for users" do
    repo.find_user("emily").mentions.sort.should == %w{ christie duncan }
  end
end
