RSpec.describe User do
  describe '#name' do
    let(:user) { FactoryGirl.build(:user, first_name: 'Brandan', last_name: 'Lennox') }
    subject { user.name }
    it { is_expected.to include('Brandan') }
    it { is_expected.to include('Lennox') }
  end
end
