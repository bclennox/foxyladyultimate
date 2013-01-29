class Player < ActiveRecord::Base
  attr_accessible :access_token, :email, :first_name, :last_name, :phone
  before_create :generate_access_token

  default_scope order('first_name ASC')
  # scope :emailable, where('email IS NOT NULL')
  # scope :emailable, where(id: [1, 2, 3, 32])
  scope :emailable, where(id: 1)

  has_many :responses
  has_many :games, through: :responses

  def name
    "#{first_name} #{last_name}"
  end

  def short_name
    if self.class.where(first_name: first_name).where('id != ?', id).exists?
      "#{first_name} #{last_name[0]}."
    else
      first_name
    end
  end

  def played_games
    games.where('starts_at < NOW()').where('responses.playing' => true)
  end

  def active?
    played_games.present? && played_games.first.starts_at > 1.month.ago
  end

private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.where(access_token: self.access_token).exists?
  end
end
