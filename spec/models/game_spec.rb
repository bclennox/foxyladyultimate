RSpec.describe Game do
  describe '::seed' do
    let(:schedule) { build(:schedule) }
    before { expect(Game).to receive(:schedule).at_least(:once).and_return(schedule) }
    before { Game.delete_all }

    it 'creates the game' do
      expect { Game.seed }.to change{Game.count}.by(1)
    end

    it 'schedules the game correctly' do
      expect(Game.seed.starts_at).to eq(schedule.next_occurrence.start_time)
    end
  end

  describe '#respond' do
    let(:player) { create(:player) }
    let(:game)   { create(:game) }

    context 'for a positive response' do
      before { game.respond(player, true) }

      describe '#confirmed_players' do
        subject { game.confirmed_players }
        it { is_expected.to include(player) }
      end

      describe '#declined_players' do
        subject { game.declined_players }
        it { is_expected.not_to include(player) }
      end
    end

    context 'for a negative response' do
      before { game.respond(player, false) }

      describe '#confirmed_players' do
        subject { game.confirmed_players }
        it { is_expected.not_to include(player) }
      end

      describe '#declined_players' do
        subject { game.declined_players }
        it { is_expected.to include(player) }
      end
    end
  end

  describe '#upcoming?' do
    context 'when the game is in the past' do
      subject { build(:game, starts_at: 1.day.ago) }
      it { is_expected.not_to be_upcoming }
    end

    context 'when the game is in the future' do
      subject { build(:game, starts_at: 1.day.from_now) }
      it { is_expected.to be_upcoming }
    end
  end

  describe '#on?' do
    context 'when the game is canceled' do
      subject { build(:game, canceled: true) }
      it { is_expected.not_to be_on }
    end

    context 'when the game is not canceled' do
      subject { build(:game, canceled: false) }
      it { is_expected.to be_on }
    end
  end

  describe '#default_location?' do
    let(:schedule) { build(:schedule) }
    before { expect(Schedule).to receive(:instance).and_return(schedule) }

    context 'when the game is at the normal location' do
      subject { build(:game, location: schedule.location) }
      it { is_expected.to be_default_location }
    end
  end
end
