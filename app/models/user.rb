class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :timeoutable
  attr_accessible :email, :password, :password_confirmation, :username
end
