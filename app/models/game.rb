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
    notify('reminder', message)
  end

  def cancel(message)
    update_attributes(canceled: true)
    notify('cancellation', message)
  end

  def reschedule(message)
    update_attributes(canceled: false)
    notify('reschedule', message)
  end

private

  def self.schedule
    @schedule ||= Schedule.instance
  end

  def ensure_location
    self.location ||= self.class.schedule.location
  end

  def notify(method, message)
    Player.emailable.pluck(:id).each do |player_id|
      QC.enqueue("NotificationService.#{method}", id, player_id, message)
    end
  end
end
