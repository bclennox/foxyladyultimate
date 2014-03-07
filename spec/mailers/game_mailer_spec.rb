require 'spec_helper'

describe GameMailer do
  let(:game) { FactoryGirl.create(:game) }
  let(:player) { FactoryGirl.create(:player) }
  let(:sender) { FactoryGirl.create(:user) }
  let(:body) { 'body' }

  { reminder: '', cancellation: 'Canceled', reschedule: 'Rescheduled' }.each_pair do |method, subject|
    describe "##{method}" do
      subject { GameMailer.send(method, game: game, player: player, sender: sender, body: body) }

      its(:subject) { should =~ /^#{subject}/ }
      its(:to) { should include(player.email) }
      its(:from) { should include(sender.email) }
      its(:attachments) { should have(1).item }
    end
  end
end
