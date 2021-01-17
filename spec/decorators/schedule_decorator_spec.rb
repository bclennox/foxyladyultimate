require 'rails_helper'

RSpec.describe ScheduleDecorator do
  describe '#available_days' do
    let(:schedule) { build(:schedule) }
    subject { schedule.decorate.available_days }
    it 'has 7 items' do
      expect(subject.size).to eq(7)
    end
  end
end
