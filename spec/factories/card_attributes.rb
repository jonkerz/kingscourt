FactoryBot.define do
  factory :card_attribute do
    is_action

    trait :is_action do
      name { "isAction" }
    end
  end
end
