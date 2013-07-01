require 'spec_helper'

describe EventService do
  let(:game) { FactoryGirl.create(:game) }
  before { game.should_receive(:updated_at).and_return(game.created_at + 1.minute) }
  subject { EventService.create_event(game).to_ical }

  it { should =~ %r(LOCATION:\s*#{game.location}) }
  it { should =~ %r(URL:\s*http://.*?/games/#{game.id}) }
  it { should =~ %r(SEQUENCE:\s*60) }
end
