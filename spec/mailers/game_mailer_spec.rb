require 'rails_helper'

RSpec.describe GameMailer do
  let(:game)   { create(:game) }
  let(:player) { create(:player, access_token: 'abc123', email: 'daniel@ray.com') }
  let(:body)   { 'body' }

  let(:sender) do
    create(:user,
      username: 'matt',
      first_name: 'Matt',
      last_name: 'Kellerman',
      email: 'matthew@kellerman.com',
      smtp_password: 'pretend'
    )
  end

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
        it { is_expected.to include('daniel@ray.com') }
      end

      describe '#from' do
        subject { mailer.from }
        it { is_expected.to include('matt@foxyladyultimate.com') }
      end

      describe '#reply_to' do
        subject { mailer.reply_to }
        it { is_expected.to include('matthew@kellerman.com') }
      end

      describe '#delivery_method_options' do
        subject { mailer.delivery_method.settings }

        it "includes the sender's SMTP username" do
          expect(subject.fetch(:user_name)).to eq('matt@foxyladyultimate.com')
        end

        it "includes the sender's SMTP password" do
          expect(subject.fetch(:password)).to eq('pretend')
        end
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
