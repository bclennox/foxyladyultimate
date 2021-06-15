FactoryBot.define do
  factory :quip do
    association(:player)
    confirmation { 'Yes' }
    rejection { 'No' }

    trait :pending do
      approved { nil }
    end

    trait :approved do
      approved { true }
    end

    trait :rejected do
      approved { false }
    end
  end
end
