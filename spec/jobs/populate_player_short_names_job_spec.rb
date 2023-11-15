require 'rails_helper'

RSpec.describe PopulatePlayerShortNamesJob do
  it 'delegates to PopulatePlayerShortNames' do
    allow(PopulatePlayerShortNames).to receive(:call)

    PopulatePlayerShortNamesJob.perform_later

    expect(PopulatePlayerShortNames).to have_received(:call)
  end
end
