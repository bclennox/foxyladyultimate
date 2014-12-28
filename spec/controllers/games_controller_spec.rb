RSpec.describe GamesController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#edit' do
      before { get :edit, id: 1 }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :update, id: 1 }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#schedule' do
      before { get :schedule }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#remind' do
      before { get :remind, id: 1 }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#cancel' do
      before { get :cancel, id: 1 }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#reschedule' do
      before { get :reschedule, id: 1 }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#index' do
      before { FactoryGirl.create_list(:game, 3) }
      before { get :index }

      it 'decorates the instances' do
        expect(assigns[:games].first).to respond_to(:player_names)
      end
    end

    describe '#show' do
      let(:game) { FactoryGirl.create(:game) }

      context 'format.html' do
        it 'renders the show template' do
          get :show, id: game
          expect(response).to render_template('show')
        end

        context 'without a saved access token' do
          it 'does not assign a player' do
            get :show, id: game
            expect(assigns[:player]).to be_nil
          end
        end

        context 'with a saved access token' do
          let(:player) { FactoryGirl.create(:player) }
          before { cookies[:access_token] = player.access_token }

          it 'assigns a player' do
            get :show, id: game
            expect(assigns[:player]).to eq(player)
          end
        end
      end

      context 'format.ics' do
        let(:event) { double('event') }
        let(:content) { 'ical content' }

        before { expect(event).to receive(:to_ical).and_return(content) }
        before { expect(EventService).to receive(:create_event).with(game).and_return(event) }
        before { get :show, id: game, format: 'ics' }

        it 'renders the game as an iCalendar event' do
          expect(response.body).to eq(content)
        end
      end
    end

    describe '#edit' do
      let(:game) { FactoryGirl.create(:game) }
      before { get :edit, id: game }

      it 'decorates the instance' do
        expect(assigns[:game]).to respond_to(:player_names)
      end

      it 'renders the edit template' do
        expect(response).to render_template('edit')
      end
    end

    describe '#update' do
      let(:game) { FactoryGirl.create(:game) }

      context 'with valid parameters' do
        let(:params) { { 'location' => 'Elsewhere' } }
        before { expect_any_instance_of(Game).to receive(:update).with(params).and_return(true) }
        before { patch :update, id: game, game: params }

        it 'redirects to the games path' do
          expect(response).to redirect_to(games_path)
        end

        it 'adds a flash message' do
          expect(flash[:notice]).to be_present
        end
      end
    end

    describe '#next' do
      before { Game.delete_all }
      let!(:past_games) { FactoryGirl.create_list(:game, 3, starts_at: 1.month.ago) }
      let!(:upcoming_game) { FactoryGirl.create(:game, starts_at: 1.week.from_now) }
      before { get :next }

      it 'assigns the last upcoming game' do
        expect(assigns[:game].id).to eq(upcoming_game.id)
      end
    end

    describe '#schedule' do
      let(:game) { FactoryGirl.create(:game) }
      before { expect(Game).to receive(:seed).and_return(game) }
      before { get :schedule }

      it 'redirects to the new game' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'adds a flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    describe '#respond' do
      let(:game) { FactoryGirl.create(:game) }
      let(:player) { FactoryGirl.create(:player) }
      let(:params) { { id: game, access_token: player.access_token } }

      before { get :respond, params }

      it 'sets the cookie' do
        expect(cookies[:access_token]).to eq(player.access_token)
      end

      it 'redirects to the game' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'adds a flash message' do
        expect(flash[:notice]).to be_present
      end

      context 'when responding "yes"' do
        let(:params) { { id: game, access_token: player.access_token, playing: 'yes' } }

        it 'responds affirmatively to the game' do
          expect(game.confirmed_players).to include(player)
        end
      end

      context 'when responding "no"' do
        let(:params) { { id: game, access_token: player.access_token, playing: 'no' } }

        it 'responds negatively to the game' do
          expect(game.declined_players).to include(player)
        end
      end
    end

    describe '#override' do
      let(:game) { FactoryGirl.create(:game) }
      let(:player) { FactoryGirl.create(:player) }

      before { post :override, params }

      context 'when responding "yes"' do
        let(:params) { { id: game, player_id: player, played: 'yes' } }

        it 'adds the player to the game' do
          expect(game.confirmed_players).to include(player)
        end

        it 'redirects to the game' do
          expect(response).to redirect_to(game_path(game))
        end
      end

      context 'when responding "no"' do
        let(:params) { { id: game, player_id: player, played: 'no' } }

        it 'removes the player from the game' do
          expect(game.unconfirmed_players).to include(player)
        end

        it 'redirects to the game' do
          expect(response).to redirect_to(game_path(game))
        end
      end
    end

    describe '#remind' do
      let(:game) { FactoryGirl.create(:game) }
      let(:message) { 'message' }

      before { expect_any_instance_of(GameNotifier).to receive(:send_reminder) }
      before { get :remind, id: game, message: message }

      it 'redirects to the game' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'adds a flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    describe '#cancel' do
      let(:game) { FactoryGirl.create(:game) }
      let(:message) { 'message' }

      before { expect_any_instance_of(GameNotifier).to receive(:send_cancellation) }
      before { get :cancel, id: game, message: message }

      it 'redirects to the game' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'adds a flash message' do
        expect(flash[:notice]).to be_present
      end
    end

    describe '#reschedule' do
      let(:game) { FactoryGirl.create(:game) }
      let(:message) { 'message' }

      before { expect_any_instance_of(GameNotifier).to receive(:send_reschedule) }
      before { get :reschedule, id: game, message: message }

      it 'redirects to the game' do
        expect(response).to redirect_to(game_path(game))
      end

      it 'adds a flash message' do
        expect(flash[:notice]).to be_present
      end
    end
  end
end
