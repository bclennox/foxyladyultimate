require 'spec_helper'

RSpec.describe EventService do
  let(:game) { FactoryGirl.create(:game) }
  before { expect(game).to receive(:updated_at).and_return(game.created_at + 1.minute) }
  subject { EventService.create_event(game).to_ical }

  it { is_expected.to match(%r(LOCATION:\s*#{game.location})) }
  it { is_expected.to match(%r(URL:\s*http://.*?/games/#{game.id})) }
  it { is_expected.to match(%r(SEQUENCE:\s*60)) }
end
