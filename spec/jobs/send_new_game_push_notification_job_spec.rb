require 'rails_helper'

RSpec.describe SendNewGamePushNotificationJob do
  let(:game) { create(:game) }

  it 'delegates to PushNotifier#notify_new_game' do
    notifier = instance_double(PushNotifier)
    expect(PushNotifier).to receive(:new).with(game: game).and_return(notifier)
    expect(notifier).to receive(:notify_new_game)

    SendNewGamePushNotificationJob.perform_now(game)
  end
end
