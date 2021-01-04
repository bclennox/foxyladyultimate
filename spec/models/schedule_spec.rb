RSpec.describe Schedule do
  context 'parsing the time' do
    let(:schedule) { build(:schedule, time: '2pm') }

    describe '#time' do
      subject { schedule.time }
      it { is_expected.to eq('14:00:00') }
    end
  end

  context 'delegation' do
    subject { create(:schedule) }

    context 'when the scheduler responds to the message' do
      it 'delegates the message' do
        expect(subject.next_occurrence).to be_present
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
    let(:schedule) { create(:schedule, day: day, time: time, location: location) }

    subject { schedule.to_s }

    it { is_expected.to include(day) }
    it { is_expected.to include(time) }
    it { is_expected.to include(location) }
  end
end
