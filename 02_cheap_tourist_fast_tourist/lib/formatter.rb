module Formatter
  def format_graph(g)
    g.root.to_s
  end

  def format_node(n, indent=0)
    n.flight.to_s + "\n" + n.connections.map { |c| " " * indent + format_node(c, indent+2) }.join
  end
end
