require 'spec_helper'

RSpec.describe ApplicationController do
  describe '#authorizer' do
    let(:user)       { FactoryGirl.build(:user) }
    let(:authorizer) { controller.authorizer }

    before { expect(controller).to receive(:current_user).and_return(user) }

    describe '#user' do
      subject { authorizer.user }
      it { is_expected.to eq(user) }
    end
  end

  describe '#layout' do
    let(:layout) { controller.layout }

    describe '#application_name' do
      subject { layout.application_name }
      it { is_expected.to eq('Foxy Lady Ultimate') }
    end

    describe '#controller' do
      subject { layout.controller }
      it { is_expected.to eq(controller) }
    end
  end
end
