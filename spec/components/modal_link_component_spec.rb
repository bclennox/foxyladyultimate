require 'rails_helper'

RSpec.describe ModalLinkComponent, type: :component do
  let(:title) { 'Add a Thing' }
  let(:url) { 'https://example.com/add_thing' }
  let(:button_text) { 'Add It' }

  before do
    render_inline described_class.new(title: , url: , button_text: ) do
      'Tell me about your thing.'
    end
  end

  it 'includes Stimulus controller' do
    expect(page).to have_selector('div[data-controller="modal-link"]')
  end

  it 'includes title' do
    expect(page).to have_selector('h5.modal-title', text: 'Add a Thing')
  end

  it 'includes content' do
    expect(page).to have_text('Tell me about your thing.')
  end

  it 'includes content' do
    expect(page).to have_button('Add It')
  end

  it 'includes link' do
    link = page.find_link('Add a Thing')

    expect(link[:href]).to eq('https://example.com/add_thing')
    expect(link['data-action']).to eq('modal-link#showModal:prevent')
    expect(link['data-turbo-prefetch']).to eq('false')
  end
end
