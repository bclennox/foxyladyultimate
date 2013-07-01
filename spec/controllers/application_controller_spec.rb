require 'spec_helper'

describe ApplicationController do
  describe '#authorizer' do
    let(:user) { FactoryGirl.build(:user) }
    before { controller.should_receive(:current_user).and_return(user) }
    subject { controller.authorizer }

    its(:user) { should == user }
  end

  describe '#layout' do
    subject { controller.layout }

    its(:application_name) { should == 'Foxy Lady Ultimate' }
    its(:controller) { should == controller }
  end
end
