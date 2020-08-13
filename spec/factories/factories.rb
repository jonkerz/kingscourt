# TODO: Get rid of these.

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
