require 'spec_helper'

describe PlayersController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#new' do
      before { get :new }
      it { should redirect_to(new_user_session_path) }
    end

    describe '#create' do
      before { post :create }
      it { should redirect_to(new_user_session_path) }
    end

    describe '#edit' do
      before { get :edit, id: 1 }
      it { should redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :update, id: 1 }
      it { should redirect_to(new_user_session_path) }
    end

    describe '#destroy' do
      before { delete :destroy, id: 1 }
      it { should redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#index' do
      let(:players) { FactoryGirl.create_list(:player, 3) }
      let(:game) { FactoryGirl.create(:game) }

      before do
        players.each { |p| game.respond(p, true) }
        get :index
      end

      it 'decorates the players' do
        assigns[:players].first.should respond_to(:attendance)
      end

      it 'ranks the players' do
        pending 'Maybe a bug in Rails that breaks the SELECT clause'
        assigns[:ranked_players].should have(3).items
      end
    end

    describe '#new' do
      before { get :new }

      it 'assigns the instance' do
        assigns[:player].should be_present
      end

      it 'renders the new template' do
        response.should render_template('new')
      end
    end

    describe '#create' do
      context 'with valid parameters' do
        let(:params) { FactoryGirl.attributes_for(:player).stringify_keys }

        it 'creates the player' do
          expect { post :create, player: params }.to change{Player.count}.by(1)
        end

        it 'redirects to the players path' do
          post :create, player: params
          response.should redirect_to(players_path)
        end

        it 'adds a flash message' do
          post :create, player: params
          flash[:notice].should be_present
        end
      end

      context 'with invalid parameters' do
        before { post :create, player: { foo: 'bar' } }

        it 'assigns the instance' do
          assigns[:player].should be_present
        end

        it 'renders the new template' do
          response.should render_template('new')
        end

        it 'adds a flash message' do
          flash[:error].should be_present
        end
      end
    end

    describe '#edit' do
      let(:player) { FactoryGirl.create(:player) }
      before { get :edit, id: player }

      it 'assigns the instance' do
        assigns[:player].should be_present
      end

      it 'renders the edit template' do
        response.should render_template('edit')
      end
    end

    describe '#update' do
      let(:player) { FactoryGirl.create(:player) }

      context 'with valid parameters' do
        let(:params) { FactoryGirl.attributes_for(:player).stringify_keys }
        before { Player.any_instance.should_receive(:update_attributes).with(params).and_return(true) }
        before { patch :update, id: player, player: params }

        it 'redirects to the players path' do
          response.should redirect_to(players_path)
        end

        it 'adds a flash message' do
          flash[:notice].should be_present
        end
      end

      context 'with invalid parameters' do
        before { patch :update, id: player, player: { first_name: '' } }

        it 'assigns the instance' do
          assigns[:player].should be_present
        end

        it 'renders the edit template' do
          response.should render_template('edit')
        end

        it 'adds a flash message' do
          flash[:error].should be_present
        end
      end
    end

    describe '#destroy' do
      let(:player) { FactoryGirl.create(:player) }
      before { Player.any_instance.should_receive(:destroy) }
      before { delete :destroy, id: player }

      it 'redirects to the players path' do
        response.should redirect_to(players_path)
      end

      it 'adds a flash message' do
        flash[:notice].should be_present
      end
    end
  end
end
