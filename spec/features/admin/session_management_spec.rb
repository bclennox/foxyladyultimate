require 'spec_helper'

feature 'Session and user management' do
  given(:username) { 'brandan' }
  given(:password) { 'nadnarb' }

  given!(:user) { FactoryGirl.create(:user, username: username, password: password) }

  context 'signing in' do
    background do
      visit root_url
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'
    end

    it 'signs me in' do
      page.should have_content('Signed in successfully.')
    end

    it 'allows me to change my password' do
      page.should have_link('Change Your Password')
    end

    it 'allows me to sign out' do
      page.should have_link('Sign Out')
    end
  end

  context 'signing out' do
    background do
      visit root_url
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'

      click_link 'Sign Out'
    end

    it 'signs me out' do
      page.should have_content('Signed out successfully.')
    end

    it 'allows me to sign in' do
      page.should have_link('Sign In')
    end
  end

  context 'redirecting after signing in' do
    background do
      visit root_url
      click_link 'Games'
      click_link 'Sign In'

      fill_in 'Username', with: username
      fill_in 'Password', with: password
      click_button 'Sign In'
    end

    it 'redirects me back to the page I was on before' do
      page.current_path.should == games_path
    end
  end
end