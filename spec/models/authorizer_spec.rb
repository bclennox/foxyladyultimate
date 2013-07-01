require 'spec_helper'

describe Authorizer do
  describe '#admin?' do
    context 'with a user' do
      subject { Authorizer.new(user: User.new) }
      it { should be_admin }
    end

    context 'without a user' do
      subject { Authorizer.new }
      it { should_not be_admin }
    end
  end
end
