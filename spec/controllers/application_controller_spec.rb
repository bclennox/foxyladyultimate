require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#authorizer' do
    let(:user)       { build(:user) }
    let(:authorizer) { controller.authorizer }

    before { expect(controller).to receive(:current_user).and_return(user) }

    describe '#user' do
      subject { authorizer.user }
      it { is_expected.to eq(user) }
    end
  end

  describe '#store_location' do
    controller do
      def index
        head :ok
      end
    end

    it 'does not store the manifest path' do
      request.env['PATH_INFO'] = '/manifest'
      get :index
      expect(session[:previous_url]).to be_nil
    end

    it 'does not store Devise paths' do
      request.env['PATH_INFO'] = '/users/sign_in'
      get :index
      expect(session[:previous_url]).to be_nil
    end

    it 'stores other paths' do
      get :index
      expect(session[:previous_url]).to be_present
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
