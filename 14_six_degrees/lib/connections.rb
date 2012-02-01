class Connections
  def initialize(repo, username)
    @repo = repo
    @username = username
  end

  def on_level(level)
    all(level) - all(level - 1)
  end

  def all(depth)
    return [] if depth < 1
    this_level_conns = direct_connections(@username)
    next_level_conns = this_level_conns.map { |name| Connections.new(@repo, name).all(depth - 1) }
    Set.new(this_level_conns).merge(next_level_conns.flatten).to_a - [@username]
  end

  def direct_connections(name)
    user = @repo.find_user(name)
    user.mentions.select do |other_name|
      other_user = @repo.find_user(other_name)
      other_user && other_user.mentions?(name)
    end
  end

end
