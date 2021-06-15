require 'rails_helper'

RSpec.describe QuipDecorator do
  describe '#approval_icon' do
    let(:decorator) { quip.decorate }

    subject { decorator.approval_icon }

    context 'when the quip is pending' do
      let(:quip) { build(:quip, :pending) }

      it 'returns a question icon' do
        expect(subject).to be_icon('question-circle-fill', 'text-info')
      end
    end

    context 'when the quip is approved' do
      let(:quip) { build(:quip, :approved) }

      it 'returns a check icon' do
        expect(subject).to be_icon('check-circle-fill', 'text-success')
      end
    end

    context 'when the quip is rejected' do
      let(:quip) { build(:quip, :rejected) }

      it 'returns an x icon' do
        expect(subject).to be_icon('x-circle-fill', 'text-danger')
      end
    end
  end
end
