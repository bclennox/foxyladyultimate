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

  def respond(player, playing)
    responses.where(player_id: player).destroy_all
    responses.create(player_id: player.id, playing: playing)
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

  def remind(user, message)
    notify('reminder', user, message)
  end

  def cancel(user, message)
    update_attributes(canceled: true)
    notify('cancellation', user, message)
  end

  def reschedule(user, message)
    update_attributes(canceled: false)
    notify('reschedule', user, message)
  end

private

  def self.schedule
    Schedule.instance
  end

  def ensure_location
    self.location ||= self.class.schedule.location
  end

  def notify(method, user, message)
    Player.emailable.pluck(:id).each do |player_id|
      QC.enqueue("NotificationService.#{method}", id, player_id, user.id, message)
    end
  end
end
