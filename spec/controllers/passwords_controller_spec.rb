require 'rails_helper'

RSpec.describe PasswordsController do
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
      context 'with correct current password' do
        before do
          patch :update, params: {
            user: {
              current_password: 'secret',
              password: 'newsecret',
              password_confirmation: 'newsecret'
            }
          }
        end

        it 'redirects to the password page' do
          expect(response).to redirect_to(edit_password_path)
        end

        it 'sets a flash notice' do
          expect(flash[:notice]).to be_present
        end
      end

      context 'with wrong current password' do
        before do
          patch :update, params: {
            user: {
              current_password: 'wrong',
              password: 'newsecret',
              password_confirmation: 'newsecret'
            }
          }
        end

        it 'does not redirect' do
          expect(response).to have_http_status(:unprocessable_content)
        end
      end
    end
  end
end
