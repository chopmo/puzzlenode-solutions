class UserRepository
  def initialize
    @users = []
  end

  def add_user(user)
    @users << user
  end

  def find_user(name)
    @users.find { |u| u.name == name }
  end

end
