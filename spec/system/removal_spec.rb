require 'rails_helper'

RSpec.describe 'Removing yourself' do
  before do
    driven_by(:playwright)
  end

  let!(:player) { create(:player) }

  context 'when no cookie is set' do
    before do
      page.driver.with_playwright_page { |pw| pw.context.clear_cookies }
      visit players_path
    end

    it 'does not show the link' do
      expect(page).to have_text(player.name)
      expect(page).not_to have_link('Remove Me from the List')
    end
  end

  context 'when the cookie is set' do
    before do
      visit root_path  # to set the domain for the cookie
      page.driver.with_playwright_page do |pw|
        pw.context.add_cookies([{ name: 'access_token', value: player.access_token, domain: URI.parse(page.server_url).host, path: '/' }])
      end
      visit players_path
      click_on 'Remove Me from the List'
    end

    context 'when the email address matches' do
      it 'removes the player' do
        fill_in 'Confirm your email', with: player.email
        click_on 'Remove Me'

        expect(page).to have_text('Removed you from the list')
        expect(page).not_to have_text(player.name)
      end
    end

    context 'when the email address does not match' do
      it 'does not remove the player' do
        fill_in 'Confirm your email', with: 'random@example.com'
        click_on 'Remove Me'

        expect(page).to have_text("Your email didn't match our records")

        visit players_path
        expect(page).to have_text(player.name)
      end
    end
  end
end
