require 'rails_helper'

RSpec.describe SendUpdatePushNotificationJob do
  let(:game) { create(:game) }

  it 'delegates to PushNotifier#notify_update' do
    notifier = instance_double(PushNotifier)
    expect(PushNotifier).to receive(:new).with(game: game).and_return(notifier)
    expect(notifier).to receive(:notify_update)

    SendUpdatePushNotificationJob.perform_now(game)
  end
end
