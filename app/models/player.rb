class Player < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :phone
  has_many :responses
  has_many :games, through: :responses

  def name
    "#{first_name} #{last_name}"
  end

  def played_games
    games.where('starts_at < NOW()').where('responses.playing' => true)
  end
end
