FactoryGirl.define do
  factory :user do
    username 'brandan'
    email 'brandan@example.com'
    password 'secret'
    password_confirmation 'secret'
    first_name 'Brandan'
    last_name 'Lennox'
  end
end
