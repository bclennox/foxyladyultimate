class SendPushNotificationsJob < ApplicationJob
  def perform(game, player, playing)
    PushNotifier.new(game: game, player: player, playing: playing).notify
  end
end
