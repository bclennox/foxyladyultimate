require 'rails_helper'

RSpec.describe ScheduleDecorator do
  describe '#available_days' do
    let(:schedule) { build(:schedule) }
    subject { schedule.decorate.available_days }
    it 'has 7 items' do
      expect(subject.size).to eq(7)
    end
  end

  describe '#summary' do
    let(:location) { build(:location, name: 'Yonder Park', url: 'http://yonder.park') }
    let(:schedule) { build(:schedule, day: 'Wednesday', time: '4pm', location: location) }

    subject { schedule.decorate.summary }

    it 'includes the recurrence' do
      expect(subject).to include('Weekly on Wednesdays at 4:00pm')
    end

    it 'includes the location link' do
      doc = Nokogiri::HTML(subject)
      link = doc.css('a').first

      expect(link.text).to eq('Yonder Park')
      expect(link[:href]).to eq('http://yonder.park')
    end
  end
end
