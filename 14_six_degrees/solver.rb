$:.unshift('lib')

require 'user_repository'
require 'input_parser'
require 'connections'

repo = UserRepository.new(InputParser.new(open(ARGV[0]).read).parse.values)

repo.users.each do |user|
  puts user.name
  level = 1
  while true
    conns = Connections.new(repo, user.name).on_level(level)
    break if conns.empty?
    puts conns.join(" ")
    level += 1
  end
  puts 
end
