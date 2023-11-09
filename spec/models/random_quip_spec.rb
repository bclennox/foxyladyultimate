require 'rails_helper'

RSpec.describe RandomQuip do
  describe '::call' do
    subject { described_class.call }

    context 'when there are quips available' do
      let(:quip) { build(:quip) }

      before do
        allow(Quip).to receive_message_chain(:active, :sample).and_return(quip)
      end

      it 'returns a random approved quip' do
        expect(subject.confirmation).to eq(quip.confirmation)
        expect(subject.rejection).to eq(quip.rejection)
      end
    end

    context 'when there are no quips available' do
      it 'returns a null object' do
        expect(subject.confirmation).to eq("I'm coming")
        expect(subject.rejection).to eq("I'm not coming")
      end
    end
  end
end
