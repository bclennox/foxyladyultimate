class Player < ActiveRecord::Base
  attr_accessible :access_token, :email, :first_name, :last_name, :phone
  before_create :generate_access_token

  default_scope order('first_name ASC')
  scope :active, where(deleted_at: nil)
  scope :emailable, active.where('email IS NOT NULL')

  has_many :responses
  has_many :games, through: :responses

  def name
    "#{first_name} #{last_name}"
  end

  def short_name
    if self.class.where(first_name: first_name).where('id != ?', id).exists?
      name
    else
      first_name
    end
  end

  def played_games
    games.on.past.where('responses.playing' => true)
  end

  def worthy?
    played_games.present? && played_games.first.starts_at > 1.month.ago
  end

  def destroy
    self.deleted_at = Time.now
    save
  end

private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.where(access_token: self.access_token).exists?
  end
end
