RSpec.describe Event do
  let(:game)         { FactoryGirl.create(:game) }
  let(:game_url)     { 'http://ultimate.dev/games/31' }
  let(:view_context) { double('ViewContext', game_url: game_url) }

  before { expect(game).to receive(:updated_at).and_return(game.created_at + 1.minute) }

  subject { Event.new(game: game, view_context: view_context).to_ical }

  it { is_expected.to match(%r(LOCATION:\s*#{game.location})) }
  it { is_expected.to match(%r(URL:\s*#{game_url})) }
  it { is_expected.to match(%r(SEQUENCE:\s*60)) }
end
