class SendReschedulePushNotificationJob < ApplicationJob
  def perform(game)
    PushNotifier.new(game: game).notify_reschedule
  end
end
