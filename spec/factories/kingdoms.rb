FactoryBot.define do
  factory :kingdom do
    transient do
      cards { nil }
    end

    name { "Ancient Kingdom" }
    user

    trait :without_cards do
      to_create { |instance| instance.save(validate: false) }
    end

    after :build do |kingdom, evaluator|
      if evaluator.cards.present?
        evaluator.cards.each do |card|
          kingdom.cards << card
        end
      end
    end
  end
end
