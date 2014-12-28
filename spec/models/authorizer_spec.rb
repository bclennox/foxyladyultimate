RSpec.describe Authorizer do
  describe '#admin?' do
    context 'with a user' do
      subject { Authorizer.new(user: User.new) }
      it { is_expected.to be_admin }
    end

    context 'without a user' do
      subject { Authorizer.new }
      it { is_expected.not_to be_admin }
    end
  end
end
