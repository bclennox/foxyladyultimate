FactoryBot.define do
  factory :player do
    first_name { 'Bilbo' }
    last_name { 'Baggins' }
    email { 'bilbo@example.com' }
    phone { '555.555.5555' }
    retired { false }

    trait :retired do
      retired { true }
    end
  end
end
