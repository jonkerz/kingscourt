FactoryBot.define do
  factory :card do
    transient do
      card_attributes { nil }
    end

    initialize_with { Card.find_or_create_by(name: name) }

    sequence(:name) { |n| "Chapel #{n}" }
    randomizable { true }
    expansion
    cost_in_text { "2" }
    cost_in_coins { 2 }

    after :create do |card, evaluator|
      if evaluator.card_attributes.present?
        evaluator.card_attributes.each do |card_attribute|
          card.card_attributes << card_attribute
        end
      end
    end
  end
end
