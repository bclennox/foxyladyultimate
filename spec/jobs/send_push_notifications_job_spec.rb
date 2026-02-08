require 'rails_helper'

RSpec.describe SendPushNotificationsJob do
  let(:game) { create(:game) }
  let(:player) { create(:player) }

  it 'delegates to PushNotifier' do
    notifier = instance_double(PushNotifier)
    expect(PushNotifier).to receive(:new).with(game: game, player: player, playing: true).and_return(notifier)
    expect(notifier).to receive(:notify_rsvp)

    SendPushNotificationsJob.perform_now(game, player, true)
  end
end
