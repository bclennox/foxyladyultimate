class GameNotifier
  include ActiveModel::Model

  attr_accessor :game, :sender, :body

  def send_reminder
    notify(:reminder)
  end

  def send_cancellation
    notify(:cancellation)
  end

  def send_reschedule
    notify(:reschedule)
  end

  private

  def notify(type)
    Player.emailable.each do |player|
      GameMailer.send(type, game, player, sender, body).deliver_later(queue: 'default')
    end
  end
end
