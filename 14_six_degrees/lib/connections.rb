class Connections
  def initialize(repo, username)
    @repo = repo
    @username = username
  end

  def on_level(level)
    if level == 1
      direct_connections(@username)
    else
      
    end
  end

  def all(depth)
    direct_connections(@username)
  end

  def direct_connections(name)
    user = @repo.find_user(name)
    user.mentions.select do |other_name|
      other_user = @repo.find_user(other_name)
      other_user.mentions?(name)
    end
  end

end
