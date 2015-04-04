RSpec.describe 'routes for players' do
  it 'routes /players/ranked.json' do
    expect(get('/players/ranked.json')).to route_to('players#ranked', format: 'json')
  end
end
