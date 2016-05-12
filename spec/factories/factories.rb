FactoryGirl.define do
  factory :card do
    initialize_with { Card.find_or_create_by name: name }
    name "Chapel"
    randomizable true
    expansion_id 1
  end

  factory :kingdom do
    transient do
      cards nil
    end
    name "Ancient Kingdom"
    user
    after(:create) do |kingdom, evaluator|
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
  end

  factory :favorite_kingdom do
    user
    kingdom
  end
end
