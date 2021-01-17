require 'rails_helper'

RSpec.describe GameMailer do
  let(:game)   { create(:game) }
  let(:player) { create(:player, access_token: 'abc123') }
  let(:sender) { create(:user) }
  let(:body)   { 'body' }

  { reminder: '', cancellation: 'Canceled', reschedule: 'Rescheduled' }.each do |method, message_subject|
    describe "##{method}" do
      let(:mailer) { GameMailer.send(method, game, player, sender, body) }

      describe 'unsubscribe' do
        subject { mailer.header['List-Unsubscribe'].value }
        it { is_expected.to include('bclennox@gmail.com?subject=Unsubscribe+abc123') }
        it { is_expected.to include(new_removal_url(access_token: 'abc123')) }
      end

      describe '#subject' do
        subject { mailer.subject }
        it { is_expected.to match(/^#{message_subject}/) }
      end

      describe '#to' do
        subject { mailer.to }
        it { is_expected.to include(player.email) }
      end

      describe '#from' do
        subject { mailer.from }
        it { is_expected.to include(sender.email) }
      end

      describe '#attachments' do
        subject { mailer.attachments }

        it 'has 1 item' do
          expect(subject.size).to eq(1)
        end
      end
    end
  end
end
