require 'rails_helper'

RSpec.describe SendCancellationPushNotificationJob do
  let(:game) { create(:game) }

  it 'delegates to PushNotifier#notify_cancellation' do
    notifier = instance_double(PushNotifier)
    expect(PushNotifier).to receive(:new).with(game: game).and_return(notifier)
    expect(notifier).to receive(:notify_cancellation)

    SendCancellationPushNotificationJob.perform_now(game)
  end
end
