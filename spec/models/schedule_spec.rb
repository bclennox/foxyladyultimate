require 'spec_helper'

describe Schedule do
  context 'parsing the time' do
    subject { FactoryGirl.build(:schedule, time: '2pm') }
    its(:time) { should == '14:00:00' }
  end

  context 'delegation' do
    subject { FactoryGirl.create(:schedule) }

    context 'when the scheduler responds to the message' do
      it 'delegates the message' do
        subject.next_occurrence.should be_present
      end
    end

    context 'when the scheduler does not respond to the message' do
      it 'raises an error' do
        expect { subject.explode }.to raise_exception(NoMethodError)
      end
    end
  end

  describe '#to_s' do
    let(:day) { 'Monday' }
    let(:time) { '6:30pm' }
    let(:location) { 'The Park' }
    let(:schedule) { FactoryGirl.create(:schedule, day: day, time: time, location: location) }

    subject { schedule.to_s }

    it { should include(day) }
    it { should include(time) }
    it { should include(location) }
  end
end
