class SendNewGamePushNotificationJob < ApplicationJob
  def perform(game)
    PushNotifier.new(game: game).notify_new_game
  end
end
