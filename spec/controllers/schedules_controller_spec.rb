require 'spec_helper'

describe SchedulesController do
  context 'before signing in' do
    before { sign_out session_user }
    subject { response }

    describe '#edit' do
      before { get :edit }
      it { should redirect_to(new_user_session_path) }
    end

    describe '#update' do
      before { patch :edit }
      it { should redirect_to(new_user_session_path) }
    end
  end

  context 'after signing in' do
    before { sign_in session_user }

    describe '#edit' do
      before { FactoryGirl.create(:schedule) }
      before { get :edit }

      it 'decorates the instance' do
        assigns[:schedule].should respond_to(:available_days)
      end
    end

    describe '#update' do
      before { FactoryGirl.create(:schedule) }

      context 'with valid parameters' do
        let(:params) { FactoryGirl.attributes_for(:schedule).stringify_keys }
        before { Schedule.any_instance.should_receive(:update_attributes).with(params).and_return(true) }
        before { patch :update, schedule: params }

        it 'redirects to the games path' do
          response.should redirect_to(games_path)
        end

        it 'adds a flash message' do
          flash[:notice].should be_present
        end
      end

      context 'with invalid parameters' do
        before { patch :update, schedule: { 'time' => 'abc' } }

        it 'decorates the instance' do
          assigns[:schedule].should respond_to(:available_days)
        end

        it 'renders the edit template' do
          response.should render_template('edit')
        end

        it 'adds a flash message' do
          flash[:error].should be_present
        end
      end
    end
  end
end
