FactoryGirl.define do
  factory :card do
    name "Chapel"
  end

  factory :kingdom do
    name "Ancient Kingdom"
    user
  end

  factory :user do
    username "Batiatus"
    email "batiatus@example.com"
    password "secret123"
  end
end

