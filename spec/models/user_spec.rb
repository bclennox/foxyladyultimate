require 'spec_helper'

describe User do
  describe '#name' do
    let(:user) { FactoryGirl.build(:user, first_name: 'Brandan', last_name: 'Lennox') }
    subject { user.name }
    it { should include('Brandan') }
    it { should include('Lennox') }
  end
end
