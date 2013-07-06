require 'spec_helper'

describe Game do
  describe '::seed' do
    let(:schedule) { FactoryGirl.build(:schedule) }
    before { Game.should_receive(:schedule).at_least(:once).and_return(schedule) }
    before { Game.delete_all }

    it 'creates the game' do
      expect { Game.seed }.to change{Game.count}.by(1)
    end

    it 'schedules the game correctly' do
      Game.seed.starts_at.should == schedule.next_occurrence.start_time
    end
  end

  describe '#respond' do
    let(:player) { FactoryGirl.create(:player) }
    subject { FactoryGirl.create(:game) }

    context 'for a positive response' do
      before { subject.respond(player, true) }
      its(:confirmed_players) { should include(player) }
      its(:declined_players) { should_not include(player) }
    end

    context 'for a negative response' do
      before { subject.respond(player, false) }
      its(:confirmed_players) { should_not include(player) }
      its(:declined_players) { should include(player) }
    end
  end

  describe '#upcoming?' do
    context 'when the game is in the past' do
      subject { FactoryGirl.build(:game, starts_at: 1.day.ago) }
      it { should_not be_upcoming }
    end

    context 'when the game is in the future' do
      subject { FactoryGirl.build(:game, starts_at: 1.day.from_now) }
      it { should be_upcoming }
    end
  end

  describe '#on?' do
    context 'when the game is canceled' do
      subject { FactoryGirl.build(:game, canceled: true) }
      it { should_not be_on }
    end

    context 'when the game is not canceled' do
      subject { FactoryGirl.build(:game, canceled: false) }
      it { should be_on }
    end
  end

  describe '#default_location?' do
    let(:schedule) { FactoryGirl.build(:schedule) }
    before { Schedule.should_receive(:instance).and_return(schedule) }

    context 'when the game is at the normal location' do
      subject { FactoryGirl.build(:game, location: schedule.location) }
      it { should be_default_location }
    end
  end

  context 'notifications' do
    let(:user) { FactoryGirl.build(:user) }
    let(:message) { 'message' }
    subject { FactoryGirl.build(:game) }
    before { subject.should_receive(:notify).with(an_instance_of(String), user, message) }

    describe '#remind' do
      before { subject.remind(user, message) }
      it { should be_on }
    end

    describe '#cancel' do
      before { subject.cancel(user, message) }
      it { should be_canceled }
    end

    describe '#reschedule' do
      before { subject.reschedule(user, message) }
      it { should be_on }
    end
  end
end
