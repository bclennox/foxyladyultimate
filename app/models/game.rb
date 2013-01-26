class Game < ActiveRecord::Base
  attr_accessible :canceled, :location, :starts_at

  has_many :responses, dependent: :destroy
  has_many :players, through: :responses

  default_scope order('starts_at DESC')
  scope :upcoming, where('starts_at > NOW()')

  def self.seed
    find_or_create_by_starts_at!(schedule.next_occurrence)
  end

  def confirmed_players
    players.where('responses.playing' => true)
  end

private

  def self.schedule
    @schedule ||= Schedule.instance
  end
end
