require 'spec_helper'

describe Layout do
  describe '#full_page_title' do
    let(:application_name) { 'Webulatr' }
    let(:layout) { Layout.new(application_name: application_name) }

    subject { layout.full_page_title }

    context 'when no page title has been set' do
      it { should == application_name }
    end

    context 'when a page title has been set' do
      before { layout.page_title = 'Home' }

      it { should include('Home') }
      it { should include(application_name) }
    end
  end

  describe '#body_class' do
    let(:controller) do
      double(:controller).tap do |c|
        c.stub(:controller_name) { 'games' }
        c.stub(:action_name) { 'index' }
      end
    end

    subject { Layout.new(controller: controller).body_class }

    it { should include(controller.controller_name) }
    it { should include(controller.action_name) }
  end
end
