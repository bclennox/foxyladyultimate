class Game < ApplicationRecord
  belongs_to :location
  has_many :responses, dependent: :destroy
  has_many :players, through: :responses
  has_many :confirmed_players, -> { merge(Response.confirmed) }, through: :responses, source: :player
  has_many :declined_players, -> { merge(Response.declined) }, through: :responses, source: :player
  before_validation :ensure_location

  scope :upcoming, -> { where('starts_at > NOW()') }
  scope :past, -> { where('starts_at < NOW()') }
  scope :on, -> { where(canceled: false) }

  def self.seed
    find_or_create_by!(starts_at: Current.schedule.next_occurrence.start_time)
  end

  def respond(player, playing)
    Game.transaction do
      responses.create_or_find_by(player:).update(playing:)
    end
  end

  def unconfirmed_players
    Player.active - confirmed_players
  end

  def upcoming?
    starts_at > Time.zone.now
  end

  def on?
    !canceled?
  end

private

  def ensure_location
    self.location = Current.schedule.location if location.blank?
  end
end
