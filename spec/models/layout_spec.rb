require 'spec_helper'

describe Layout do
  describe '#page_title' do
    let(:application_name) { 'Webulatr' }
    subject { Layout.new(application_name: application_name) }

    context 'when no page title has been set' do
      its(:page_title) { should == application_name }
    end

    context 'when a page title has been set' do
      before { subject.page_title = 'Home' }

      its(:page_title) { should include('Home') }
      its(:page_title) { should include(application_name) }
    end
  end

  describe '#body_class' do
    let(:controller) do
      double(:controller).tap do |c|
        c.stub(:controller_name) { 'games' }
        c.stub(:action_name) { 'index' }
      end
    end

    subject { Layout.new(controller: controller) }

    its(:body_class) { should include(controller.controller_name) }
    its(:body_class) { should include(controller.action_name) }
  end
end
