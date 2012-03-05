require 'stacker'

interpreter = Stacker::Interpreter.new
lines = open(ARGV[0]).read.lines
lines.each do |line|
  interpreter.execute(line)
end

puts interpreter.stack.join("\n")
