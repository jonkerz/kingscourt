FactoryBot.define do
  factory :user do
    initialize_with { User.find_or_create_by(username: username) }

    username { "Joffre" }
    email { "#{username.downcase}@example.com" }
    password { "secret123" }
    password_confirmation { "secret123" }
  end
end
