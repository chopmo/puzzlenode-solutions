class City
  def initialize(name)
    @name = name
  end

  attr_reader :name

  def to_s
    name
  end

  def outgoing
    @outgoing ||= []
  end


end
