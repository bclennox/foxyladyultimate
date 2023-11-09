require 'rails_helper'

RSpec.describe PlayersController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#new' do
      before { get :new }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#create' do
      before { post :create }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#edit' do
      before { get :edit, params: { id: 1 } }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :update, params: { id: 1 } }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#destroy' do
      before { delete :destroy, params: { id: 1 } }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#index' do
      let(:players) { create_list(:player, 3) }
      let(:game) { create(:game, starts_at: 1.week.ago) }

      before do
        players.each { |p| game.respond(p, true) }
        get :index
      end

      it 'decorates the players' do
        expect(controller.players.first).to respond_to(:attendance)
      end
    end

    describe '#ranked' do
      let(:players) { create_list(:player, 3) }
      let(:game) { create(:game, starts_at: 1.week.ago) }

      before do
        players.each { |p| game.respond(p, true) }
        get :ranked, format: 'json'
      end

      it 'ranks the players' do
        expect(controller.players.size).to eq(3)
      end
    end

    describe '#new' do
      before { get :new }

      it 'assigns the instance' do
        expect(controller.player).to be_present
      end

      it 'renders the new template' do
        expect(response).to have_http_status(200)
      end
    end

    describe '#create' do
      context 'with valid parameters' do
        let(:player_params) { attributes_for(:player).stringify_keys }

        it 'creates the player' do
          expect { post :create, params: { player: player_params } }.to change{Player.count}.by(1)
        end

        it 'redirects to the players path' do
          post :create, params: { player: player_params }
          expect(response).to redirect_to(players_path)
        end

        it 'adds a flash message' do
          post :create, params: { player: player_params }
          expect(flash[:notice]).to be_present
        end
      end

      context 'with invalid parameters' do
        before { post :create, params: { player: { foo: 'bar' } } }

        it 'assigns the instance' do
          expect(controller.player).to be_present
        end

        it 'renders the new template' do
          expect(response).to have_http_status(200)
        end

        it 'adds a flash message' do
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe '#edit' do
      let(:player) { create(:player) }
      before { get :edit, params: { id: player } }

      it 'assigns the instance' do
        expect(controller.player).to be_present
      end

      it 'renders the edit template' do
        expect(response).to have_http_status(200)
      end
    end

    describe '#update' do
      let(:player) { create(:player) }

      context 'with valid parameters' do
        let(:player_params) { attributes_for(:player).stringify_keys }
        before { expect_any_instance_of(Player).to receive(:update).and_return(true) }
        before { patch :update, params: { id: player, player: player_params } }

        it 'redirects to the players path' do
          expect(response).to redirect_to(players_path)
        end

        it 'adds a flash message' do
          expect(flash[:notice]).to be_present
        end
      end

      context 'with invalid parameters' do
        before { patch :update, params: { id: player, player: { first_name: '' } } }

        it 'assigns the instance' do
          expect(controller.player).to be_present
        end

        it 'renders the edit template' do
          expect(response).to have_http_status(200)
        end

        it 'adds a flash message' do
          expect(flash[:alert]).to be_present
        end
      end
    end

    describe '#destroy' do
      let(:player) { create(:player) }

      context 'when successful' do
        before { expect_any_instance_of(Player).to receive(:destroy).and_return(true) }
        before { delete :destroy, params: { id: player } }

        it 'adds a flash message' do
          expect(flash[:notice]).to be_present
        end

        it 'redirects to the players path' do
          expect(response).to redirect_to(players_path)
        end
      end

      context 'when unsuccessful' do
        before { expect_any_instance_of(Player).to receive(:destroy).and_return(false) }
        before { delete :destroy, params: { id: player } }

        it 'adds a flash message' do
          expect(flash[:alert]).not_to be_nil
        end

        it 'redirects to the players path' do
          expect(response).to redirect_to(players_path)
        end
      end
    end
  end
end
