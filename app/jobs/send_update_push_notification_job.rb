class SendUpdatePushNotificationJob < ApplicationJob
  def perform(game)
    PushNotifier.new(game: game).notify_update
  end
end
