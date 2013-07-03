class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :timeoutable

  def name
    "#{first_name} #{last_name}"
  end
end
