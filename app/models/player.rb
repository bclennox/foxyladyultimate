class Player < ApplicationRecord
  before_create :generate_access_token, unless: -> { access_token.present? }

  before_validation :generate_short_name, if: -> { short_name.blank? }
  validates_presence_of :first_name, :last_name, :short_name, :email

  default_scope -> { order(first_name: :asc) }
  scope :active, -> { where(deleted_at: nil) }
  scope :emailable, -> { active.where.not(email: nil).where(retired: false) }

  has_one :user, primary_key: :email, foreign_key: :email

  has_many :responses
  has_many :games, through: :responses
  has_many :confirmed_games, -> { on.merge(Response.confirmed) }, through: :responses, source: :game

  def name
    "#{first_name} #{last_name}"
  end

  def worthy?
    confirmed_games.present? && confirmed_games.last.starts_at > 1.month.ago
  end

  def destroy
    update(deleted_at: Time.zone.now)
  end

  private

  def generate_short_name
    self.short_name = name
  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.where(access_token: self.access_token).exists?
  end
end
