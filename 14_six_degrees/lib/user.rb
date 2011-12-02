require 'set'

class User
  attr_reader :name
  attr_reader :mentions

  def initialize(attrs = {})
    @name = attrs[:name]
    @mentions = Set.new(attrs.fetch(:mentions) { [] })
  end

  def add_mention(name)
    @mentions << name
  end
end
