RSpec.feature 'Player management' do
  background do
    admin = FactoryGirl.create(:user, username: 'brandan', password: 'nadnarb')

    visit new_user_session_path

    fill_in 'Username', with: admin.username
    fill_in 'Password', with: admin.password
    click_button 'Sign In'
  end

  context 'adding a player' do
    given(:first_name) { 'Jeff' }
    given(:last_name) { 'Winger' }
    given(:email) { 'jeffrey@greendale.edu' }
    given(:phone) { '919.919.9191' }

    background do
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
    given(:old_first_name) { 'Ben' }
    given(:old_last_name)  { 'Chang' }
    given(:new_first_name) { 'Kevin' }
    given(:new_last_name)  { 'Parker' }

    given!(:player) { FactoryGirl.create(:player, first_name: old_first_name, last_name: old_last_name) }

    background do
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
    given!(:player) { FactoryGirl.create(:player) }

    background do
      click_link 'Players'
      click_link '', href: player_path(player)
    end

    it 'no longer shows the player in the list'
  end
end
