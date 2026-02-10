require 'rails_helper'

RSpec.describe ProfilesController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#edit' do
      before { get :edit }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :update }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#edit' do
      before { get :edit }

      it 'renders the edit template' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe '#update' do
      context 'updating profile' do
        before { patch :update, params: { user: { first_name: 'New', last_name: 'Name', email: 'new@example.com' } } }

        it 'updates the profile' do
          session_user.reload
          expect(session_user.first_name).to eq('New')
          expect(session_user.last_name).to eq('Name')
          expect(session_user.email).to eq('new@example.com')
        end

        it 'redirects to the profile page' do
          expect(response).to redirect_to(edit_profile_path)
        end

        it 'sets a flash notice' do
          expect(flash[:notice]).to be_present
        end
      end
    end
  end
end
