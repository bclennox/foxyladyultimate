require 'spec_helper'

describe Player do
  describe '#name' do
    let(:player) { FactoryGirl.build(:player, first_name: 'Brandan', last_name: 'Lennox') }
    subject { player.name }
    it { should include('Brandan') }
    it { should include('Lennox') }
  end

  describe '#short_name' do
    let(:original) { FactoryGirl.create(:player, first_name: 'Nerf', last_name: 'Derbler') }
    subject { original.short_name }

    context 'when no other players with the same first name exist' do
      before { Player.where(first_name: original.first_name).delete_all }
      it { should == original.first_name }
    end

    context 'when another player with the same first name exists' do
      before { FactoryGirl.create(:player, first_name: 'Nerf', last_name: 'Zerbder') }
      it { should == original.name }
    end
  end

  describe '#worthy?' do
    subject { FactoryGirl.create(:player) }

    context 'when the player has never played' do
      it { should_not be_worthy }
    end

    context 'when the player has played in the deep past' do
      let(:game) { FactoryGirl.create(:game, starts_at: 1.year.ago) }
      before { game.respond(subject, true) }
      it { should_not be_worthy }
    end

    context 'when the player has played recently' do
      let(:game) { FactoryGirl.create(:game, starts_at: 1.week.ago) }
      before { game.respond(subject, true) }
      it { should be_worthy }
    end
  end

  describe '#destroy' do
    subject { FactoryGirl.create(:player) }
    before do
      subject.destroy
      subject.reload
    end

    its(:deleted_at) { should be_present }
  end
end
