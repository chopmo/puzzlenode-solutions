module StackOperations
  # XXX: use delegation
  def push(e)
    @stack.push(e)
  end

  def pop
    @stack.pop
  end
end
