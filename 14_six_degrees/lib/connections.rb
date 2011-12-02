class Connections
  def initialize(repo)
    @repo = repo
  end

  def for(name, level)
    user = @repo.find_user(name)
    user.mentions.select do |other_name|
      other_user = @repo.find_user(other_name)
      other_user.mentions?(name)
    end
  end

end
