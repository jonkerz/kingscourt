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
    cost_in_text "2"
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

def create_dominion_cards
  standard = create :expansion, name: "Dominion", id: 1

  %w(Cellar Chapel Moat Chancellor Village
    Woodcutter Workshop Bureaucrat Feast Gardens).each do |name|
    create :card, name: name, expansion: standard
  end
end

def create_intrigue_cards
  intrigue = create :expansion, name: "Intrigue", id: 2

  %w(Courtyard Pawn Secret\ Chamber Great\ Hall Masquerade
    Shanty\ Town Steward Swindler Wishing\ Well Baron).each do |name|
    create :card, name: name, expansion: intrigue
  end
end

def create_dominion_kingdom name: "Dominion"
  standard = Expansion.find_by!(name: "Dominion")

  build(:kingdom,
    name: name,
    description: "Very dangerous kingdom.",
    cards: standard.cards.take(10)).save!
end

def create_intrigue_kingdom name: "Intrigue"
  intrigue = Expansion.find_by!(name: "Intrigue")

  build(:kingdom,
    name: name,
    cards: intrigue.cards.take(10),
    user: create(:user, username: "Batiatus")).save!
end

def create_mixed_dominion_intrigue_kingdom name: "Dominion and Intrigue"
  standard = Expansion.find_by!(name: "Dominion")
  intrigue = Expansion.find_by!(name: "Intrigue")

  cards = standard.cards.take(5) + intrigue.cards.take(5)

  build(:kingdom,
    name: name,
    cards: cards,
    user: create(:user, username: "Batiatus")).save!
end
