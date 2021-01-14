require 'rails_helper'

RSpec.describe 'Session and user management' do
  let(:username) { 'brandan' }
  let(:password) { 'nadnarb' }

  let!(:user) { create(:user, username: username, password: password) }

  context 'signing in' do
    before do
      visit root_url
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'
    end

    it 'signs me in' do
      expect(page).to have_content('Signed in successfully.')
    end

    it 'allows me to change my password' do
      expect(page).to have_link('Change Your Password')
    end

    it 'allows me to sign out' do
      expect(page).to have_link('Sign Out')
    end
  end

  context 'signing out' do
    before do
      visit root_url
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'

      click_link 'Sign Out'
    end

    it 'signs me out' do
      expect(page).to have_content('Signed out successfully.')
    end

    it 'allows me to sign in' do
      expect(page).to have_link('Sign In')
    end
  end

  context 'redirecting after signing in' do
    before do
      visit root_url
      click_link 'Games'
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'
    end

    it 'redirects me back to the page I was on before' do
      expect(page.current_path).to eq(games_path)
    end
  end
end
