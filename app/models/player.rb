class Player < ActiveRecord::Base
  before_create :generate_access_token
  after_commit :flush_cache

  validates_presence_of :first_name, :last_name, :email

  default_scope -> { order(first_name: :asc) }
  scope :active, -> { where(deleted_at: nil) }
  scope :emailable, -> { active.where.not(email: nil) }

  has_many :responses
  has_many :games, through: :responses

  def name
    "#{first_name} #{last_name}"
  end

  def short_name
    Rails.cache.fetch([self, 'short_name']) do
      self.class.where(first_name: first_name).where.not(id: id).exists? ? name : first_name
    end
  end

  def played_games
    Rails.cache.fetch([self, 'played_games']) do
      games.on.past.where(responses: { playing: true }).to_a
    end
  end

  def worthy?
    played_games.present? && played_games.first.starts_at > 1.month.ago
  end

  def destroy
    update(deleted_at: Time.zone.now)
  end

private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.where(access_token: self.access_token).exists?
  end

  def flush_cache
    self.class.all.each(&:touch)
  end
end
