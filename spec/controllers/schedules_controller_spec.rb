require 'spec_helper'

RSpec.describe SchedulesController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#edit' do
      before { get :edit }
      it { is_expected.to redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :edit }
      it { is_expected.to redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#edit' do
      before { FactoryGirl.create(:schedule) }
      before { get :edit }

      it 'decorates the instance' do
        expect(assigns[:schedule]).to respond_to(:available_days)
      end
    end

    describe '#update' do
      before { FactoryGirl.create(:schedule) }

      context 'with valid parameters' do
        let(:params) { FactoryGirl.attributes_for(:schedule).stringify_keys }
        before { expect_any_instance_of(Schedule).to receive(:update_attributes).with(params).and_return(true) }
        before { patch :update, schedule: params }

        it 'redirects to the games path' do
          expect(response).to redirect_to(games_path)
        end

        it 'adds a flash message' do
          expect(flash[:notice]).to be_present
        end
      end

      context 'with invalid parameters' do
        before { patch :update, schedule: { 'time' => 'abc' } }

        it 'decorates the instance' do
          expect(assigns[:schedule]).to respond_to(:available_days)
        end

        it 'renders the edit template' do
          expect(response).to render_template('edit')
        end

        it 'adds a flash message' do
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end
