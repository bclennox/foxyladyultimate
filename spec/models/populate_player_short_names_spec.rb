require 'rails_helper'

RSpec.describe PopulatePlayerShortNames do
  let!(:brandan) { create(:player, first_name: 'Brandan', last_name: 'Lennox') }
  let!(:brandon) { create(:player, first_name: 'Brandon', last_name: 'Lennax') }
  let!(:diana_j) { create(:player, first_name: 'Diana', last_name: 'Jarosiewicz') }
  let!(:diana_k) { create(:player, first_name: 'Diana', last_name: 'Kuster') }

  before { PopulatePlayerShortNames.call }

  it 'updates player short names' do
    expect(brandan.reload.short_name).to eq('Brandan')
    expect(brandon.reload.short_name).to eq('Brandon')
    expect(diana_j.reload.short_name).to eq('Diana Jarosiewicz')
    expect(diana_k.reload.short_name).to eq('Diana Kuster')
  end
end
