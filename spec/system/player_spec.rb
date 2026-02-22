require 'rails_helper'

RSpec.describe 'Player management' do
  def sign_in
    admin = create(:user, username: 'brandan', password: 'nadnarb')

    visit new_user_session_path

    fill_in 'Username', with: admin.username
    fill_in 'Password', with: admin.password
    click_button 'Sign In'

    expect(page).to have_text('Signed in successfully.')
  end

  context 'adding a player' do
    let(:first_name) { 'Jeff' }
    let(:last_name) { 'Winger' }
    let(:email) { 'jeffrey@greendale.edu' }
    let(:phone) { '919.919.9191' }

    before do
      sign_in

      click_link 'Players'
      click_link 'Add a Player'

      fill_in 'First name', with: first_name
      fill_in 'Last name', with: last_name
      fill_in 'Email', with: email
      fill_in 'Phone', with: phone
      click_button 'Create Player'
    end

    it 'shows the new player as an e-mail link' do
      expect(page).to have_link("#{first_name} #{last_name}")
    end

    it 'shows their phone number' do
      expect(page).to have_content(phone)
    end
  end

  context 'editing a player' do
    let(:old_first_name) { 'Ben' }
    let(:old_last_name)  { 'Chang' }
    let(:new_first_name) { 'Kevin' }
    let(:new_last_name)  { 'Parker' }

    let!(:player) { create(:player, first_name: old_first_name, last_name: old_last_name) }

    before do
      sign_in

      click_link 'Players'
      click_link '', href: edit_player_path(player)

      fill_in 'First name', with: new_first_name
      fill_in 'Last name', with: new_last_name
      click_button 'Update Player'
    end

    it 'updates the player information' do
      expect(page).to have_link("#{new_first_name} #{new_last_name}")
    end
  end

  context 'deleting a player' do
    let!(:player) { create(:player, first_name: 'Zaboo', last_name: 'the Warlock') }

    before do
      driven_by(:playwright)
      sign_in
      visit players_path
    end

    it 'no longer shows the player in the list' do
      expect(page).to have_link('Zaboo the Warlock')

      accept_confirm 'Remove Zaboo the Warlock?' do
        find("a[href='#{player_path(player)}'] svg").click
      end

      expect(page).to have_text('Player was successfully removed.')
      expect(page).not_to have_link('Zaboo the Warlock')
    end
  end
end
