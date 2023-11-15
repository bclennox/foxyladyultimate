class Player < ApplicationRecord
  before_create :generate_access_token, unless: -> { access_token.present? }
  after_commit :flush_cache

  validates_presence_of :first_name, :last_name, :email

  default_scope -> { order(first_name: :asc) }
  scope :active, -> { where(deleted_at: nil) }
  scope :emailable, -> { active.where.not(email: nil).where(retired: false) }

  has_many :responses
  has_many :games, through: :responses
  has_many :confirmed_games, -> { merge(Response.confirmed) }, through: :responses, source: :game

  def name
    "#{first_name} #{last_name}"
  end

  def short_name
    Rails.cache.fetch([self, 'short_name']) do
      self.class.where(first_name: first_name).where.not(id: id).exists? ? name : first_name
    end
  end

  def worthy?
    confirmed_games.present? && confirmed_games.first.starts_at > 1.month.ago
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
    Rails.cache.clear
  end
end
