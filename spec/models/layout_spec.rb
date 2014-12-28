RSpec.describe Layout do
  describe '#full_page_title' do
    let(:application_name) { 'Webulatr' }
    let(:layout) { Layout.new(application_name: application_name) }

    subject { layout.full_page_title }

    context 'when no page title has been set' do
      it { is_expected.to eq(application_name) }
    end

    context 'when a page title has been set' do
      before { layout.page_title = 'Home' }

      it { is_expected.to include('Home') }
      it { is_expected.to include(application_name) }
    end
  end

  describe '#body_class' do
    let(:controller) do
      double(:controller).tap do |c|
        allow(c).to receive(:controller_name) { 'games' }
        allow(c).to receive(:action_name) { 'index' }
      end
    end

    subject { Layout.new(controller: controller).body_class }

    it { is_expected.to include(controller.controller_name) }
    it { is_expected.to include(controller.action_name) }
  end
end
