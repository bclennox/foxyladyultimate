require 'rails_helper'

RSpec.describe 'Password reset' do
  let(:username) { 'brandan' }
  let(:password) { 'nadnarb' }

  let!(:user) { create(:user, username: username, password: password) }

  def reset_password_url
    mail = ActionMailer::Base.deliveries.last
    mail.body.to_s[%r{http://[^"'\s]*/users/password/edit[^"'\s]*}]
  end

  context 'requesting instructions' do
    before do
      visit new_user_password_path

      fill_in 'Email', with: user.email
      # Devise 4 and 5 word this button differently, so match on the element.
      find('input[type="submit"]').click
    end

    it 'tells me to check my email' do
      expect(page).to have_content('You will receive an email with instructions about how to reset your password in a few minutes.')
    end

    it 'sends me a reset link' do
      expect(reset_password_url).to be_present
    end
  end

  context 'following the reset link' do
    before do
      visit new_user_password_path

      fill_in 'Email', with: user.email
      # Devise 4 and 5 word this button differently, so match on the element.
      find('input[type="submit"]').click

      visit reset_password_url

      fill_in 'New password', with: 'brandnew'
      fill_in 'Confirm new password', with: 'brandnew'
      click_button 'Change my password'
    end

    it 'changes my password and signs me in' do
      expect(page).to have_content('Your password was changed successfully. You are now signed in.')
    end

    it 'lets me sign in with the new password afterward' do
      find('.dropdown-toggle', text: 'Brandan').click
      click_link 'Sign Out'

      visit new_user_session_path
      fill_in 'Username', with: username
      fill_in 'Password', with: 'brandnew'
      click_button 'Sign In'

      expect(page).to have_content('Signed in successfully.')
    end
  end

  context 'following an invalid reset link' do
    before do
      visit edit_user_password_path(reset_password_token: 'not-a-real-token')

      fill_in 'New password', with: 'brandnew'
      fill_in 'Confirm new password', with: 'brandnew'
      click_button 'Change my password'
    end

    it 'refuses to change my password' do
      expect(page).to have_content('Reset password token is invalid')
    end
  end
end
