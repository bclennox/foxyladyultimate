class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :timeoutable

  belongs_to :player, primary_key: :email, foreign_key: :email, optional: true
  has_many :push_subscriptions, dependent: :destroy

  validates :password, confirmation: true

  encrypts :smtp_password

  def name
    "#{first_name} #{last_name}"
  end

  def smtp_username
    "#{username}@foxyladyultimate.com"
  end
end
