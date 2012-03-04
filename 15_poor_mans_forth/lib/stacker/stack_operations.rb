module StackOperations
  # XXX: use delegation
  def push(e)
    @data.push(e)
  end

  def pop
    @data.pop
  end
end
