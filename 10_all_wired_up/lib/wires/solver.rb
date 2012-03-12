class Solver
  def initialize(diagram)
    @diagram = diagram
    solve
  end

  attr_reader :solution

  private
  def solve
    @solution = @diagram.lightbulb.value ? "on" : "off"
  end

end
