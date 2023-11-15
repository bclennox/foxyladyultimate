require 'rails_helper'

RSpec.describe Player do
  describe '::emailable' do
    before do
      create_list(:player, 4)
      create_list(:player, 3, :retired)
    end

    subject { Player.emailable.count }

    it { is_expected.to eq(4) }
  end

  describe '#name' do
    let(:player) { build(:player, first_name: 'Brandan', last_name: 'Lennox') }
    subject { player.name }
    it { is_expected.to include('Brandan') }
    it { is_expected.to include('Lennox') }
  end

  describe '#short_name' do
    let(:original) { create(:player, first_name: 'Nerf', last_name: 'Derbler') }
    subject { original.short_name }

    context 'when no other players with the same first name exist' do
      before { Player.where(first_name: original.first_name).delete_all }
      it { is_expected.to eq(original.first_name) }
    end

    context 'when another player with the same first name exists' do
      before { create(:player, first_name: 'Nerf', last_name: 'Zerbder') }
      it { is_expected.to eq(original.name) }
    end
  end

  describe '#worthy?' do
    subject { create(:player) }

    context 'when the player has never played' do
      it { is_expected.not_to be_worthy }
    end

    context 'when the player has played in the deep past' do
      let(:game) { create(:game, starts_at: 1.year.ago) }
      before { game.respond(subject, true) }
      it { is_expected.not_to be_worthy }
    end

    context 'when the player has played recently' do
      let(:game) { create(:game, starts_at: 1.week.ago) }
      before { game.respond(subject, true) }
      it { is_expected.to be_worthy }
    end
  end

  describe '#destroy' do
    let(:player) { create(:player) }

    describe '#deleted_at' do
      subject do
        player.destroy
        player.reload.deleted_at
      end

      it { is_expected.to be_present }
    end
  end

  describe 'access tokens' do
    subject { player.access_token }

    context 'when no token is specified' do
      let(:player) { create(:player, access_token: nil) }
      it { is_expected.to be_present }
    end

    context 'when a token is specified' do
      let(:player) { create(:player, access_token: 'abc123') }
      it { is_expected.to eq('abc123') }
    end
  end

  describe '#confirmed_games' do
    let(:player) { create(:player) }

    let!(:confirmed_canceled_game) { create(:game, canceled: true) }
    let!(:confirmed_active_game) { create(:game, canceled: false) }
    let!(:declined_game) { create(:game, canceled: false) }
    let!(:ignored_game) { create(:game, canceled: false) }

    before do
      confirmed_canceled_game.respond(player, true)
      confirmed_active_game.respond(player, true)
      declined_game.respond(player, false)
    end

    subject { player.confirmed_games }

    it { is_expected.to     include(confirmed_active_game) }
    it { is_expected.not_to include(confirmed_canceled_game) }
    it { is_expected.not_to include(declined_game) }
    it { is_expected.not_to include(ignored_game) }
  end
end
