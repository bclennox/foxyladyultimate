class Game < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :players, through: :responses
  has_many :confirmed_players, -> { merge(Response.confirmed) }, through: :responses, source: :player
  has_many :declined_players, -> { merge(Response.declined) }, through: :responses, source: :player
  before_validation :ensure_location

  scope :upcoming, -> { where('starts_at > NOW()') }
  scope :past, -> { where('starts_at < NOW()') }
  scope :on, -> { where(canceled: false) }

  def self.seed
    find_or_create_by!(starts_at: schedule.next_occurrence.start_time)
  end

  def respond(player, playing)
    responses.where(player_id: player).destroy_all
    responses.create(player_id: player.id, playing: playing)
  end

  def unconfirmed_players
    Player.active - confirmed_players
  end

  def upcoming?
    starts_at > Time.now
  end

  def on?
    !canceled?
  end

  def default_location?
    location == self.class.schedule.location
  end

private

  def self.schedule
    Schedule.instance
  end

  def ensure_location
    self.location = self.class.schedule.location if location.blank?
  end
end
