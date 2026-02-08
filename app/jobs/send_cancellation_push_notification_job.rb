class SendCancellationPushNotificationJob < ApplicationJob
  def perform(game)
    PushNotifier.new(game: game).notify_cancellation
  end
end
