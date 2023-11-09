require 'rails_helper'

RSpec.describe QuipDecorator do
  describe '#active_icon' do
    let(:decorator) { quip.decorate }

    subject { decorator.active_icon }

    context 'when the quip is active' do
      let(:quip) { build(:quip, active: true) }

      it 'returns an icon' do
        expect(subject).to be_icon('check-circle-fill')
      end
    end

    context 'when the quip is inactive' do
      let(:quip) { build(:quip, active: false) }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
