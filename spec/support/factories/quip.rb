FactoryBot.define do
  factory :quip do
    confirmation { 'Yes' }
    rejection { 'No' }
    active { false }
  end
end
