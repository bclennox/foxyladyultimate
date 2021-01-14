require 'rails_helper'

RSpec.describe 'Home page' do
  it 'shows a heading' do
    visit root_url
    expect(page).to have_content('Next Game')
  end

  context 'when no game is scheduled' do
    it 'says as much' do
      visit root_url
      expect(page).to have_content('Nothing scheduled yet.')
    end
  end

  context 'when a game is scheduled' do
    let!(:game) { create(:game, starts_at: Time.now + 1.day) }
    let!(:brandan) { create(:player, first_name: 'Brandan', last_name: 'Lennox') }
    let!(:lindsay) { create(:player, first_name: 'Lindsay', last_name: 'Mooring') }

    before do
      game.respond(brandan, true)
      game.respond(lindsay, false)
    end

    it 'shows the game date' do
      visit root_url
      expect(page).to have_content(game.starts_at.strftime(GameDecorator.date_format))
    end

    it 'shows how many people are playing' do
      visit root_url
      expect(page).to have_content('1 player')
    end
  end

  context 'when a game has been canceled' do
    let!(:game) { create(:game, starts_at: Time.now + 1.day, canceled: true) }

    it 'says as much' do
      visit root_url
      expect(page).to have_content("It’s canceled.")
    end
  end
end
