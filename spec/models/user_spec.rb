require 'rails_helper'

RSpec.describe User do
  describe '#name' do
    let(:user) { build(:user, first_name: 'Brandan', last_name: 'Lennox') }
    subject { user.name }
    it { is_expected.to include('Brandan') }
    it { is_expected.to include('Lennox') }
  end

  describe '#player' do
    let(:user) { create(:user, email: 'shared@example.com') }

    context 'when a player exists with the same email' do
      let!(:player) { create(:player, email: 'shared@example.com') }

      it 'returns the matching player' do
        expect(user.player).to eq(player)
      end
    end

    context 'when no player exists with the same email' do
      it 'returns nil' do
        expect(user.player).to be_nil
      end
    end
  end
end
