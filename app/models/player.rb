class Player < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone
  has_many :responses

  def name
    "#{first_name} #{last_name}"
  end
end
