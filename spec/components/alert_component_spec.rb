require 'rails_helper'

RSpec.describe AlertComponent, type: :component do
  let(:type) { :anything }

  before { render_inline AlertComponent.new(type: , message: 'message goes here') }

  it 'includes alert classes' do
    expect(page).to have_selector('.alert.alert-dismissible.alert-anything.fade.show.mt-3[role="alert"]')
  end

  it 'includes the message as text' do
    expect(page).to have_selector('.alert', text: 'message goes here')
  end

  describe 'with notice' do
    let(:type) { :notice }

    it 'includes success class' do
      expect(page).to have_selector('.alert.alert-success')
    end
  end

  describe 'with alert' do
    let(:type) { :alert }

    it 'includes danger class' do
      expect(page).to have_selector('.alert.alert-danger')
    end
  end

  # Layout#flash_messages relies on this to skip empty flashes
  describe '#blank?' do
    it 'is blank without a message' do
      expect(AlertComponent.new(type: :notice, message: '')).to be_blank
    end

    it 'is not blank with a message' do
      expect(AlertComponent.new(type: :notice, message: 'hello')).not_to be_blank
    end
  end
end
