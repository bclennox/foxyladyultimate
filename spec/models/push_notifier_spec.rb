require 'rails_helper'

RSpec.describe PushNotifier do
  let(:game) { create(:game) }
  let(:player) { create(:player) }

  describe '#notify_rsvp' do
    context 'with no subscriptions' do
      it 'does nothing' do
        expect(WebPush).not_to receive(:payload_send)
        PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
      end
    end

    context 'with subscriptions' do
      let!(:subscription) { create(:push_subscription) }

      it 'sends a push notification for a positive RSVP' do
        expect(WebPush).to receive(:payload_send).with(hash_including(
          endpoint: subscription.endpoint,
          p256dh: subscription.p256dh,
          auth: subscription.auth
        ))

        PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
      end

      it 'includes the player name and positive status in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['body']).to include(player.short_name)
          expect(payload['body']).to include('is playing')
        end

        PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
      end

      it 'includes the player name and negative status in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['body']).to include(player.short_name)
          expect(payload['body']).to include("can't make it")
        end

        PushNotifier.new(game: game, player: player, playing: false).notify_rsvp
      end

      it 'includes the game date in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['body']).to include(game.starts_at.strftime('%A, %B %-d'))
        end

        PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
      end

      it 'includes the game URL in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['url']).to eq("/games/#{game.id}")
        end

        PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
      end
    end

    context 'with an expired subscription' do
      let!(:subscription) { create(:push_subscription) }

      it 'destroys the expired subscription' do
        response = double(body: 'expired', inspect: 'expired')
        expect(WebPush).to receive(:payload_send).and_raise(WebPush::ExpiredSubscription.new(response, 'push.example.com'))

        expect {
          PushNotifier.new(game: game, player: player, playing: true).notify_rsvp
        }.to change(PushSubscription, :count).by(-1)
      end
    end
  end

  describe '#notify_cancellation' do
    context 'with no subscriptions' do
      it 'does nothing' do
        expect(WebPush).not_to receive(:payload_send)
        PushNotifier.new(game: game).notify_cancellation
      end
    end

    context 'with subscriptions' do
      let!(:subscription) { create(:push_subscription) }

      it 'sends a push notification' do
        expect(WebPush).to receive(:payload_send).with(hash_including(
          endpoint: subscription.endpoint,
          p256dh: subscription.p256dh,
          auth: subscription.auth
        ))

        PushNotifier.new(game: game).notify_cancellation
      end

      it 'includes "canceled" in the body' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['body']).to include('canceled')
        end

        PushNotifier.new(game: game).notify_cancellation
      end

      it 'includes the game date in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['body']).to include(game.starts_at.strftime('%A, %B %-d'))
        end

        PushNotifier.new(game: game).notify_cancellation
      end

      it 'includes the game URL in the payload' do
        expect(WebPush).to receive(:payload_send) do |args|
          payload = JSON.parse(args[:message])
          expect(payload['url']).to eq("/games/#{game.id}")
        end

        PushNotifier.new(game: game).notify_cancellation
      end
    end

    context 'with an expired subscription' do
      let!(:subscription) { create(:push_subscription) }

      it 'destroys the expired subscription' do
        response = double(body: 'expired', inspect: 'expired')
        expect(WebPush).to receive(:payload_send).and_raise(WebPush::ExpiredSubscription.new(response, 'push.example.com'))

        expect {
          PushNotifier.new(game: game).notify_cancellation
        }.to change(PushSubscription, :count).by(-1)
      end
    end
  end
end
