require 'spec_helper'

describe 'routes for games' do
  it 'routes /games/schedule' do
    expect(get('/games/schedule')).to route_to('games#schedule')
  end

  it 'routes /games/1/respond' do
    expect(get('/games/1/respond')).to route_to('games#respond', id: '1')
  end

  it 'routes /games/1/override' do
    expect(post('/games/1/override')).to route_to('games#override', id: '1')
  end

  it 'routes /games/1/remind' do
    expect(post('/games/1/remind')).to route_to('games#remind', id: '1')
  end

  it 'routes /games/1/cancel' do
    expect(post('/games/1/cancel')).to route_to('games#cancel', id: '1')
  end

  it 'routes /games/1/reschedule' do
    expect(post('/games/1/reschedule')).to route_to('games#reschedule', id: '1')
  end

  it 'routes the root URL' do
    expect(get('/')).to route_to('games#next')
  end
end
