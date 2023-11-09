require 'rails_helper'

RSpec.describe 'Player management' do
  def sign_in
    admin = create(:user, username: 'brandan', password: 'nadnarb')

    visit new_user_session_path

    fill_in 'Username', with: admin.username
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
  end

  context 'adding a quip' do
    before do
      sign_in

      click_link 'Quips'
      click_link 'Add a Quip'

      fill_in 'Confirmation', with: 'Yep'
      fill_in 'Rejection', with: 'Nope'
      check 'Active'
      click_button 'Create Quip'
    end

    it 'creates the quip' do
      expect(page).to have_content('Yep')
      expect(page).to have_content('Nope')
      expect(page).to have_selector('i.bi.bi-check-circle-fill')
    end
  end

  context 'updating a quip' do
    before do
      create(:quip, confirmation: 'Yah', rejection: 'Nah', active: true)

      sign_in

      click_link 'Quips'
      click_link 'Edit'

      fill_in 'Confirmation', with: 'What?'
      fill_in 'Rejection', with: 'Huh?'
      uncheck 'Active'
      click_button 'Update Quip'
    end

    it 'updates the quip' do
      expect(page).to have_content('What?')
      expect(page).to have_content('Huh?')
      expect(page).not_to have_selector('i.bi.bi-check-circle-fill')
    end
  end
end
