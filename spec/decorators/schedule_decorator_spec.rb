require 'spec_helper'

describe ScheduleDecorator do
  describe '#available_days' do
    let(:schedule) { FactoryGirl.build(:schedule) }
    subject { schedule.decorate.available_days }
    it { should have(7).items }
  end
end
