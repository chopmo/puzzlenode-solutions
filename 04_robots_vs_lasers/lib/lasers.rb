module Lasers
  module_function
  
  def path(belt, direction)
    north_line, robot_line, south_line = *belt.lines
    robot_idx = robot_line.index("X")

    # Create the forward paths from the viewpoint of the robot
    north_path, south_path = \
    if direction == :east
      [north_line[robot_idx..-1],
       south_line[robot_idx..-1]]
    else
      [north_line[0..robot_idx].reverse,
       south_line[0..robot_idx].reverse]
    end

    # Combine to a single path of "active" positions
    path_size = north_path.size
    (0...path_size).map { |i| i.even? ? north_path[i] : south_path[i] }.join
  end

  def hits(p)
    p.chars.select { |c| c == "|" }.size
  end

  def solve(input)
    belts = input.split(/^\n/)
    belts.map { |belt| hits(path(belt, :west)) <= hits(path(belt, :east)) ? "GO WEST" : "GO EAST" }
  end
end
