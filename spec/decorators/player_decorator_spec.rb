require 'spec_helper'

describe PlayerDecorator do
  describe '#attendance' do
    let(:player) { FactoryGirl.create(:player) }
    subject { player.decorate }

    context 'when the player has never played' do
      its(:attendance) { should == 'Never played' }
    end

    context 'when the player has played a few games' do
      let(:games) { FactoryGirl.create_list(:game, 3, starts_at: 1.week.ago) }

      before do
        games.each { |game| game.respond(player, true) }
      end

      its(:attendance) { should include('3 games') }
    end
  end
end
