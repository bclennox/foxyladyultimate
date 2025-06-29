class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :timeoutable

  validates :password, confirmation: true

  encrypts :smtp_password

  def name
    "#{first_name} #{last_name}"
  end

  def smtp_username
    "#{username}@foxyladyultimate.com"
  end
end
