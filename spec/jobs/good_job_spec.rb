require 'rails_helper'

RSpec.describe GoodJob do
  it 'is migrated' do
    expect(GoodJob).to be_migrated
  end
end
