class UserRepository
  def initialize(users = nil)
    @users = Array(users)
  end

  def add_user(user)
    @users << user
  end

  def find_user(name)
    @users.find { |u| u.name == name }
  end

  def users
    @users.sort_by(&:name)
  end
end
