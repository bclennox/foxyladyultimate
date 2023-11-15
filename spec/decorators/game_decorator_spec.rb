require 'rails_helper'

RSpec.describe GameDecorator do
  describe '#date' do
    let(:game) { build(:game, starts_at: Time.zone.parse('Jun 30, 2013 14:00:00')) }
    subject { game.decorate.date }

    it { is_expected.to include('Sunday') }
    it { is_expected.to include('June') }
    it { is_expected.to include('30') }
    it { is_expected.to include('2013') }
    it { is_expected.to include('2:00pm') }
  end

  describe '#confirmed_player_names' do
    let(:game) { build(:game) }
    subject { game.decorate }
    before { expect(game).to receive(:confirmed_players).and_return('confirmed_players') }

    it 'delegates to #player_names' do
      expect(subject).to receive(:player_names).with('confirmed_players')
      subject.confirmed_player_names
    end
  end

  describe '#declined_player_names' do
    let(:game) { build(:game) }
    subject { game.decorate }
    before { expect(game).to receive(:declined_players).and_return('declined_players') }

    it 'delegates to #player_names' do
      expect(subject).to receive(:player_names).with('declined_players')
      subject.declined_player_names
    end
  end

  describe '#player_names' do
    let(:game) { build(:game) }
    subject { game.decorate.player_names(players) }

    context 'with no responses' do
      let(:players) { [] }

      context 'when the game has passed' do
        before { game.starts_at = 1.week.ago }
        it { is_expected.to eq('No one') }
      end

      context 'when the game is upcoming' do
        before { game.starts_at = 1.day.from_now }
        it { is_expected.to eq('No one yet') }
      end
    end

    context 'with one response' do
      let(:players) { [build(:player, short_name: 'Vulfmon')] }
      it { is_expected.to eq('Vulfmon') }
    end

    context 'with two responses' do
      let(:players) do
        [
          build(:player, short_name: 'Louis'),
          build(:player, short_name: 'Genevieve')
        ]
      end

      it { is_expected.to eq("Louis and Genevieve") }
    end

    context 'with more than two responses' do
      let(:players) do
        [
          build(:player, short_name: 'John'),
          build(:player, short_name: 'Paul'),
          build(:player, short_name: 'George'),
          build(:player, short_name: 'Ringo'),
        ]
      end

      it { is_expected.to eq('John, Paul, George, and Ringo') }
    end
  end
end
