class Authorizer
  attr_accessor :user

  def initialize(user: nil)
    @user = user
  end

  def admin?
    user.present?
  end
end
