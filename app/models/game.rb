class Game < ActiveRecord::Base
  attr_accessible :canceled, :location, :starts_at

  has_many :responses, dependent: :destroy
  has_many :players, through: :responses
  before_validation :ensure_location

  default_scope order('starts_at DESC')
  scope :upcoming, where('starts_at > NOW()')

  def self.seed
    find_or_create_by_starts_at!(schedule.next_occurrence)
  end

  def confirmed_players
    players.where('responses.playing' => true)
  end

  def declined_players
    players.where('responses.playing' => false)
  end

  def upcoming?
    starts_at > Time.now
  end

  def remind(message)
    Player.emailable.each do |player|
      QC.enqueue('NotificationService.reminder', id, player.id, message)
    end
  end

private

  def self.schedule
    @schedule ||= Schedule.instance
  end

  def ensure_location
    self.location ||= 'Dillard Drive Elementary'
  end
end
