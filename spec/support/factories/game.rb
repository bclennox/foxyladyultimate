FactoryGirl.define do
  factory :game do
    location 'The Park'
    starts_at { Time.now }
    canceled false
  end
end
