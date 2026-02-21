require 'rails_helper'

RSpec.describe AccessTokenController do
  class Harness < ApplicationController
    include AccessTokenController
  end

  describe '#set_player_by_params_access_token!' do
    let(:harness) { Harness.new }
    let!(:player) { create(:player, access_token: player_access_token) }

    let!(:params_spy) { Spy.on(harness, :params).and_return(access_token: 'abc123') }

    subject { harness.set_player_by_params_access_token! }

    context 'when a player is found' do
      let(:player_access_token) { 'abc123' }

      it 'returns the player' do
        expect(subject).to eq(player)
        expect(params_spy).to have_been_called
        expect(harness.instance_variable_get(:@player)).to eq(player)
      end
    end

    context 'when a player is not found' do
      let(:player_access_token) { 'anything' }
      let!(:redirect_spy) { Spy.on(harness, :redirect_to).and_return('redirected') }
      let!(:path_spy) { Spy.on(harness, :root_path).and_return('root') }

      it 'redirects to root' do
        expect(subject).to eq('redirected')
        expect(params_spy).to have_been_called
        expect(path_spy).to have_been_called
        expect(redirect_spy).to have_been_called_with('root')
        expect(harness.instance_variable_get(:@player)).to be_nil
      end
    end
  end

  describe '#set_player_from_session' do
    let(:harness) { Harness.new }

    subject { harness.set_player_from_session }

    context 'when a user is signed in' do
      let!(:user) { create(:user) }
      let!(:user_spy) { Spy.on(harness, :current_user).and_return(user) }

      it 'returns the player from the user' do
        expect(subject).to eq(user.player)
        expect(harness.instance_variable_get(:@player)).to eq(user.player)
      end
    end

    context 'when no user is signed in but cookie is set' do
      let!(:player) { create(:player, access_token: 'abc123') }
      let!(:user_spy) { Spy.on(harness, :current_user).and_return(nil) }
      let!(:cookie_spy) { Spy.on(harness, :cookies).and_return(access_token: 'abc123') }

      it 'returns the player from the cookie' do
        expect(subject).to eq(player)
        expect(cookie_spy).to have_been_called
        expect(harness.instance_variable_get(:@player)).to eq(player)
      end
    end

    context 'when no user is signed in and no cookie is set' do
      let!(:user_spy) { Spy.on(harness, :current_user).and_return(nil) }
      let!(:cookie_spy) { Spy.on(harness, :cookies).and_return({}) }

      it 'returns nil' do
        expect(subject).to be_nil
        expect(cookie_spy).to have_been_called
        expect(harness.instance_variable_get(:@player)).to be_nil
      end
    end
  end
end
