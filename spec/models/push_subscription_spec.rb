require 'rails_helper'

RSpec.describe PushSubscription do
  describe 'validations' do
    subject { build(:push_subscription) }

    it { is_expected.to be_valid }

    it 'requires endpoint' do
      subject.endpoint = nil
      expect(subject).not_to be_valid
    end

    it 'requires p256dh' do
      subject.p256dh = nil
      expect(subject).not_to be_valid
    end

    it 'requires auth' do
      subject.auth = nil
      expect(subject).not_to be_valid
    end

    it 'requires unique endpoint' do
      create(:push_subscription, endpoint: 'https://push.example.com/dup')
      subject.endpoint = 'https://push.example.com/dup'
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      subject = build(:push_subscription, user: nil)
      expect(subject).not_to be_valid
    end
  end
end
