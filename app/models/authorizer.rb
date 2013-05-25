class Authorizer
  attr_accessor :user

  def initialize(options = {})
    @user = options[:user]
  end

  def admin?
    user.present?
  end
end
