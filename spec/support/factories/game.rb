FactoryBot.define do
  factory :game do
    location
    starts_at { Time.now }
    canceled { false }
  end
end
