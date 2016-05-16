FactoryGirl.define do
  factory :card do
    transient do
      card_attributes nil
    end
    initialize_with { Card.find_or_create_by name: name }
    sequence :name do |n|
      "Chapel #{n}"
    end
    randomizable true
    expansion
    cost "2"
    cost_in_coins 2

    after :create do |card, evaluator|
      if evaluator.card_attributes.present?
        evaluator.card_attributes.each do |card_attribute|
          card.card_attributes << card_attribute
        end
      end
    end
  end

  factory :card_attribute do
    name "isAction"
  end

  factory :card_type

  factory :expansion do
    initialize_with { Expansion.find_or_create_by name: name }
    name "Dominion"
    id 1
  end

  factory :kingdom do
    transient do
      cards nil
    end
    name "Ancient Kingdom"
    user
    after :build do |kingdom, evaluator|
      if evaluator.cards.present?
        evaluator.cards.each do |card|
          kingdom.cards << card
        end
      end
    end
  end

  factory :user do
    initialize_with do
      User.find_or_create_by username: username
    end
    username "Joffre"
    email { "#{username.downcase}@example.com" }
    password "secret123"
    password_confirmation "secret123"
  end

  factory :favorite_kingdom do
    user
    kingdom
  end
end
