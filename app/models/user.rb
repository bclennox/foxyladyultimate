class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :timeoutable

  validates :password, confirmation: true

  def name
    "#{first_name} #{last_name}"
  end
end
