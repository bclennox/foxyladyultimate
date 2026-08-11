require 'rails_helper'

RSpec.describe 'Game actions' do
  def sign_in
    admin = create(:user, username: 'brandan', password: 'nadnarb')

    visit new_user_session_path

    fill_in 'Username', with: admin.username
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
  end

  context 'for an upcoming game' do
    let!(:game) { create(:game, starts_at: Time.now + 1.day) }

    before do
      sign_in
      visit game_path(game)
    end

    it 'shows the reminder modal' do
      expect(page).to have_link('Send a Reminder')
      expect(page).to have_selector("form[action='#{remind_game_path(game)}']")
      expect(page).to have_button('Send Reminder')
      expect(page).to have_content('For the game on')
      expect(page).to have_field('message', with: 'Who can make it?')
    end

    it 'shows the cancellation modal' do
      expect(page).to have_link('Cancel this Game')
      expect(page).to have_selector("form[action='#{cancel_game_path(game)}']")
      expect(page).to have_button('Cancel Game')
    end
  end

  context 'for a canceled game' do
    let!(:game) { create(:game, starts_at: Time.now + 1.day, canceled: true) }

    before do
      sign_in
      visit game_path(game)
    end

    it 'shows the reschedule modal' do
      expect(page).to have_link('Reschedule this Game')
      expect(page).to have_selector("form[action='#{reschedule_game_path(game)}']")
      expect(page).to have_button('Reschedule Game')
    end
  end
end
