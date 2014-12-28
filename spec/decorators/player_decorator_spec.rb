RSpec.describe PlayerDecorator do
  describe '#attendance' do
    let(:player)    { FactoryGirl.create(:player) }
    let(:decorator) { player.decorate }

    context 'when the player has never played' do
      describe '#attendance' do
        subject { decorator.attendance }
        it { is_expected.to eq('Never played') }
      end
    end

    context 'when the player has played a few games' do
      let(:games) { FactoryGirl.create_list(:game, 3, starts_at: 1.week.ago) }

      before do
        games.each { |game| game.respond(player, true) }
      end

      describe '#attendance' do
        subject { decorator.attendance }
        it { is_expected.to include('3 games') }
      end
    end
  end
end
