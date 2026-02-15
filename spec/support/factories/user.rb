FactoryBot.define do
  factory :user do
    username { 'brandan' }
    email { 'brandan@example.com' }
    password { 'secret' }
    password_confirmation { password }
    first_name { 'Brandan' }
    last_name { 'Lennox' }
    smtp_password { 'fake' }

    # Associate with matching player
    after(:build) do |user|
      user.player = create(:player,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name
      )
    end
  end
end
