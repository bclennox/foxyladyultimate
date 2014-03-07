require 'spec_helper'

describe NotificationService do
  context 'delegation' do
    context 'when GameMailer responds to the message' do
      let(:game) { FactoryGirl.create(:game) }
      let(:player) { FactoryGirl.create(:player) }
      let(:user) { FactoryGirl.create(:user) }
      let(:body) { 'body' }
      let(:mailer) { double('mailer').as_null_object }

      it 'delegates to GameMailer' do
        GameMailer.should_receive(:reminder).with(game: game, player: player, sender: user, body: body).and_return(mailer)
        NotificationService.reminder(game.id, player.id, user.id, body)
      end
    end

    context 'when GameMailer does not respond to the message' do
      it 'raises an error' do
        expect { NotificationService.explode }.to raise_exception(NoMethodError)
      end
    end
  end
end
