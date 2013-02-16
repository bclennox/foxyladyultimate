class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :timeoutable
  attr_accessible :email, :password, :password_confirmation, :username

  def name
    "#{first_name} #{last_name}"
  end
end
