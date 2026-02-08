require 'rails_helper'

RSpec.describe SendReschedulePushNotificationJob do
  let(:game) { create(:game) }

  it 'delegates to PushNotifier#notify_reschedule' do
    notifier = instance_double(PushNotifier)
    expect(PushNotifier).to receive(:new).with(game: game).and_return(notifier)
    expect(notifier).to receive(:notify_reschedule)

    SendReschedulePushNotificationJob.perform_now(game)
  end
end
