require 'user'
require 'user_repository'

class InputParser
  def initialize(text)
    @text = text
  end

  def parse
    users = Hash.new { |hash, key| hash[key] = User.new(name: key) }
    @text.lines.map(&:strip).reject(&:empty?).each do |line|
      md = /([^:]+): (.+)/.match(line)
      sender, tweet = *md.captures
      mentions = tweet.scan(/@(\w+)/).flatten
      mentions.each { |m| users[sender].add_mention(m) }
    end
    UserRepository.new(users.values)
  end

end
