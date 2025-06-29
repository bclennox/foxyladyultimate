FactoryBot.define do
  factory :user do
    username { 'brandan' }
    email { 'brandan@example.com' }
    password { 'secret' }
    password_confirmation { password }
    first_name { 'Brandan' }
    last_name { 'Lennox' }
    smtp_password { 'fake' }
  end
end
